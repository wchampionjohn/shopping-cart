import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Thead from './Thead'
import Product from './Product'

export default class Table extends Component {

  isEditable =  (productId) => {
    return this.props.selectedProductIds.indexOf(productId) !== -1
  }

  renderProducts = () => {
    const {
      products,
      editingProducts,
      keyword,
      isEditMode,
      onProductSelect,
      selectedProductIds,
      onSelectAllProducts,
      onChangeProduct,
      onDeleteProduct
    } = this.props

    if(products.length > 0) {
      return (
        products.map((product,index) =>
                     <Product
                       key={index}
                       product={product}
                       editingProduct={editingProducts[product.id]}
                       keyword={keyword}
                       isEditMode={isEditMode}
                       selectedProductIds={selectedProductIds}
                       onProductSelect={onProductSelect}
                       onChangeProduct={onChangeProduct}
                       onDeleteProduct={onDeleteProduct} />
                    )
      )
    } else {
      return (<tr className="no-records-found"><td colSpan="10">No matching records found</td></tr>)
    }


  }

  render() {

    const {
      onSelectAllProducts,
      isEditMode
    } = this.props

    return (
      <div className="table-scrollable">
      <table className="table table-striped table-bordered table-advance table-hover table-list">
        <Thead isEditMode={isEditMode} onSelectAllProducts={onSelectAllProducts} />

        <tbody>
          {this.renderProducts()}
        </tbody>
      </table>
    </div>
    )
  }
}
