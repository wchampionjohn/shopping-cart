import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Product extends Component {

  handleClick = e => {
    this.props.onProductSelect(parseInt(e.target.value))
  }

  handleChange = e => {

    let obj = { }
    let newProduct = {}

    obj[e.target.name] = e.target.value
    const product = Object.assign(this.state.product, obj)
    newProduct[product.id] = product

    this.props.onChangeProduct(newProduct)
    this.setState({product: product})
  }

  handleDelete = id => {
    var isSure = confirm('Are you sure want to delete this data?');

    if(isSure){
      this.props.onDeleteProduct(id)
    }
  }


  renderKeywordColumn(text, keyword) {
    let keywordStart = text.toLowerCase().indexOf(keyword.toLowerCase())
    if (keywordStart === -1) {
      return text;
    }

    const filteredText = text.split(new RegExp(keyword, 'gi')).reduce((accu, current, i) => {
      if (i === 0) {
        return accu.concat(current);
      }

      const heightlight = text.substring(keywordStart, keywordStart + keyword.length)
      return accu.concat(<i style={{color: 'red'}}>{heightlight}</i>, current);

    }, []);

    return filteredText;
  }

  renderStatusSelect = (selectedStatus) => {

    const options = Object.keys(this.props.statuses).map((status, index) => (
      <option key={index} value={status} >{this.props.statuses[status]}</option>
    ))

    return (
      <select className="form-control select" name="status" value={selectedStatus} onChange={this.handleChange}>
        { options }
      </select>
    )
  }

  isEditing =  (productId) => {
    const { selectedProductIds, isEditMode } = this.props
    return (selectedProductIds.indexOf(productId) !== -1 && isEditMode)
  }

  render() {

    const { product, statuses, keyword, selectedProductIds, isEditMode, editingProduct } = this.props

    this.state = { product: this.props.editingProduct || {} }

    return (
      <tr>
        {!isEditMode &&
          <td className="ui-helper-center">
            <input type="checkbox"
              value={product.id}
              onChange={this.handleClick}
              checked={selectedProductIds.indexOf(product.id) !== -1} />
          </td>
        }
        {!isEditMode &&
          <td className="ui-helper-center">
            <a
              className="btn btn-default btn-xs"
              href={`products/${product.id}/edit`}>
              <i className="fa fa-pencil"></i>
            </a>
            <button
              className="btn btn-default btn-xs"
              type="buttton"
              onClick={() => this.handleDelete(product.id)}>
              <i className="fa fa-trash-o"></i>
            </button>
          </td>
        }
        {!isEditMode &&
          <td>
            {product.id}
          </td>
        }

        <td>
          {this.isEditing(product.id)
            ? <input
                type="text"
                name="title"
                value={this.state.product.title}
                onChange={this.handleChange}
                className="form-control"
                size="108" />
            : this.renderKeywordColumn(product.title, keyword)}
        </td>
        <td>
          {this.isEditing(product.id)
            ? <input
              type="text"
              name="price"
              value={this.state.product.price}
              onChange={this.handleChange}
              size="6" />
            : product.price}
        </td>
        <td className="ui-helper-center">
          {this.isEditing(product.id)
            ? this.renderStatusSelect(this.state.product.status)
            : statuses[product.status]}
        </td>
        <td>
          {this.isEditing(product.id)
            ? <input
              type="text"
              name="remain"
              value={this.state.product.remain}
              onChange={this.handleChange}
              className="form-control"
              size="6" />
            : product.remain}
        </td>
        {!isEditMode &&
          <td>
            {product.updated_at}
          </td>
        }
        {!isEditMode &&
          <td>
            {product.created_at}
          </td>
        }
      </tr>
    )
  }
}
