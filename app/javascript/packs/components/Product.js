import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Product extends Component {

  render() {

    const { product } = this.props

    return (
      <tr>
        <td className="ui-helper-center">
          <input type="checkbox" />
        </td>
        <td className="ui-helper-center">
          <button className="btn btn-default btn-xs" type="buttton">
            <i className="glyphicon glyphicon-pencil"></i>
          </button>
          <button className="btn btn-default btn-xs" type="buttton">
            <i className="glyphicon glyphicon glyphicon-trash"></i>
          </button>
        </td>
        <td>
          {product.id}
        </td>
        <td>
          {product.title}
        </td>
        <td>
          {product.description}
        </td>
        <td>
          {product.price}
        </td>
        <td className="ui-helper-center">
          {product.status}
        </td>
        <td>
          {product.calculate}
        </td>
        <td>
          {product.updated_at}
        </td>
        <td>
          {product.created_at}
        </td>
      </tr>
    )
  }
}
