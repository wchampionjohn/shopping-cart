import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Thead from './Thead'
import Product from './Product'

export default class Table extends Component {

  isEditable =  (productId) => {
    return this.props.selectedProductIds.indexOf(productId) !== -1
  }

  render() {

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

    return (
      <table className="grid table table-bordered table-sortable">
        <Thead isEditMode={isEditMode} onSelectAllProducts={onSelectAllProducts} />

        <tbody>
          {products.map(product =>
                        <Product
                          key={product.id}
                          product={product}
                          editingProduct={editingProducts[product.id]}
                          keyword={keyword}
                          isEditMode={isEditMode}
                          selectedProductIds={selectedProductIds}
                          onProductSelect={onProductSelect}
                          onChangeProduct={onChangeProduct}
                          onDeleteProduct={onDeleteProduct} />
          )}
        </tbody>
      </table>
    )
  }
}
