import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Toolbar from '../components/ToolBar'
import Table from '../components/Table'
import Page from '../components/Page'
import * as actions from '../actions'

class App extends Component {

  componentWillMount() {
    this.timer = null;
  }


  handleSearch = keyword => {

    const { dispatch } = this.props

    clearTimeout(this.timer);

    this.timer = setTimeout(function () {
      dispatch(actions.fetchPosts({keyword: keyword}))
      dispatch(actions.searchKeyword(keyword))
    }, 1000);
  }

  handleSwitchPage = page => {
    this.props.dispatch(actions.fetchPosts({page: page, keyword: this.props.keyword}))
  }

  handleSwitchEditMode = () => {

    const { dispatch } = this.props

    dispatch(actions.turnOnEditMode())
  }

  handleCloseEditMode = () => {

    const { dispatch } = this.props

    dispatch(actions.turnOffEditMode())
    dispatch(actions.setEditingProducts({}))
  }

  handleProductSelect = (productId) => {

    const { dispatch } = this.props

    dispatch(actions.selectProduct(productId))
  }

  handleSelectAll = (isChecked) => {

    const { dispatch, products } = this.props
    let ids = []

    if(isChecked) {
      ids = products.map(function(product){
        return product.id
      })
    }

    dispatch(actions.triggerSelectAllProducts(ids))
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

    dispatch(actions.setEditingProducts(editingProducts))
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

    dispatch(actions.saveProducts(newProdcuts))

  }

  handleDeleteProducts = (ids) => {
    this.props.dispatch(actions.deleteProducts(ids))
    this.props.dispatch(actions.setEditingProducts({}))
    this.props.dispatch(actions.clearSelectedProductIds())
  }

  render() {

    const {
      dispatch,
      products,
      keyword,
      isEditMode,
      selectedProductIds,
      editingProducts,
      pagination,
      handleProductChange,
      handleDeleteProduct,
      clearKeyword,
      fetchPosts
    } = this.props

    return (
      <div>
          <Toolbar
            onSearch={this.handleSearch}
            clearKeyword={() => clearKeyword()}
            fetchPosts={() => fetchPosts()}
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
            onChangeProduct={(product) => handleProductChange(product)}
            onDeleteProduct={(id) => handleDeleteProduct(id)}
            selectedProductIds={selectedProductIds}
            products={products}
            keyword={keyword}
            isEditMode={isEditMode}
            editingProducts={editingProducts} />
        <div className="row">
          <div className="col-md-12">
            <div className="pull-left">
              <Page pagination={pagination} onSwitchPage={this.handleSwitchPage}/>
            </div>
          </div>
        </div>
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

const mapDispatchToProps = (dispatch) => ({
  dispatch: dispatch,
  handleProductChange: (product) => {
    dispatch(actions.changeProduct(product))
  },
  handleDeleteProduct: (id) => {
    dispatch(actions.deleteProduct(id))
  },
  clearKeyword: () => {
    dispatch(actions.clearKeyword())
  },
  fetchPosts: () => {
    dispatch(actions.fetchPosts())
  }
})

export default connect(
  mapStateToProps, mapDispatchToProps
)(App)
