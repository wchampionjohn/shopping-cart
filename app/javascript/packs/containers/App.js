import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Toolbar from '../components/ToolBar'
import Table from '../components/Table'
import Page from '../components/Page'

import {
  fetchPosts,
  searchKeyword,
  clearKeyword,
  switchEditMode,
  closeEditMode,
  selectProduct,
  triggerSelectAllProducts,
  setEditingProducts,
  changeProduct,
  saveProducts,
  deleteProduct,
  deleteProducts,
  clearSelectedProductIds
} from '../actions'

class App extends Component {

  componentWillMount() {
    this.timer = null;
  }

  componentDidMount() {
    const { dispatch, products } = this.props
    dispatch(fetchPosts())
  }

  handleSearch = keyword => {

    const { dispatch } = this.props

    clearTimeout(this.timer);

    this.timer = setTimeout(function () {
      dispatch(fetchPosts({keyword: keyword}))
      dispatch(searchKeyword(keyword))
    }, 1000);
  }

  handleSwitchPage = page => {
    this.props.dispatch(fetchPosts({page: page, keyword: this.props.keyword}))
  }

  handleRefresh = () => {

    const { dispatch } = this.props

    dispatch(clearKeyword())
    dispatch(fetchPosts())
  }

  handleSwitchEditMode = () => {

    const { dispatch } = this.props

    dispatch(switchEditMode())
  }

  handleCloseEditMode = () => {

    const { dispatch } = this.props

    dispatch(closeEditMode())
      dispatch(setEditingProducts({}))
  }

  handleProductSelect = (productId) => {

    const { dispatch } = this.props

    dispatch(selectProduct(productId))
  }

  handleSelectAll = (isChecked) => {

    const { dispatch, products } = this.props
    let ids = []

    if(isChecked) {
      ids = products.map(function(product){
        return product.id
      })
    }

    dispatch(triggerSelectAllProducts(ids))
  }

  handleSetEditingProducts = () => {

    const { dispatch, products, selectedProductIds } = this.props

    const editingProducts = products.reduce((result, product) => {
      if(selectedProductIds.indexOf(product.id) !== -1) {
        let obj = {}
        obj[product.id] = Object.assign({}, product)
        return Object.assign(result, obj)
      } else {
        return result
      }
    }, {})

    dispatch(setEditingProducts(editingProducts))
  }

  handleProductChange = (product) => {
    this.props.dispatch(changeProduct(product))
  }

  handleSaveProducts = () => {
    const { dispatch, products, editingProducts, selectedProductIds } = this.props

    const newProdcuts = products.map((product) => {
      if(selectedProductIds.indexOf(product.id) !== -1) {
        return editingProducts[product.id]
      } else {
        return product
      }

    })

    dispatch(saveProducts(newProdcuts))

  }

  handleDeleteProduct = (id) => {
    this.props.dispatch(deleteProduct(id))
  }

  handleDeleteProducts = (ids) => {
    this.props.dispatch(deleteProducts(ids))
    this.props.dispatch(setEditingProducts({}))
    this.props.dispatch(clearSelectedProductIds())
  }

  render() {

    const { dispatch, products, keyword, isEditMode, selectedProductIds, editingProducts, pagination } = this.props

    return (
      <div>
        <Toolbar
          onSearch={this.handleSearch}
          onRefresh={this.handleRefresh}
          onSwitchEditMode={this.handleSwitchEditMode}
          onCloseEditMode={this.handleCloseEditMode}
          onSetEditingProducts={this.handleSetEditingProducts}
          onSaveProducts={this.handleSaveProducts}
          onDeleteProducts={this.handleDeleteProducts}
          selectedProductIds={selectedProductIds}
          isEditMode={isEditMode} />
        <Table
          onProductSelect={this.handleProductSelect}
          onSelectAllProducts={this.handleSelectAll}
          onChangeProduct={this.handleProductChange}
          onDeleteProduct={this.handleDeleteProduct}
          selectedProductIds={selectedProductIds}
          products={products}
          keyword={keyword}
          isEditMode={isEditMode}
          editingProducts={editingProducts} />
        <Page pagination={pagination} onSwitchPage={this.handleSwitchPage}/>
      </div>
    )
  }
}

const mapStateToProps = state => ({
  products: state.products,
  keyword: state.keyword,
  isEditMode: state.isEditMode,
  selectedProductIds: state.selectedProductIds,
  editingProducts: state.editingProducts,
  pagination: state.pagination
})

export default connect(
  mapStateToProps
)(App)
