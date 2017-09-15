import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Thead from './Thead'
import Product from './Product'

export default class Table extends Component {

  render() {

    const { products } = this.props

    return (
      <table className="grid table table-bordered table-sortable">
        <Thead />
        <tbody>
            {products.map(product =>
              <Product key={product.id} product={product}  />
            )}
        </tbody>
      </table>
    )
  }
}
