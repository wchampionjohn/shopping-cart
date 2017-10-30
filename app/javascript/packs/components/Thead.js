import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Thead extends Component {

  handleSelectAll = e => {
    this.props.onSelectAllProducts(e.target.checked)
  }

  render() {

    const { isEditMode, onSelectAllProducts } = this.props

    return (
      <thead>
        <tr>
          { !isEditMode &&
            <th className="ui-helper-center">
              <input type="checkbox" className="md-check" value="" onChange={this.handleSelectAll} />
            </th>
          }
          { !isEditMode && <th></th> }
          { !isEditMode && <th>#</th> }
          <th>Name
            { isEditMode && <span>*</span> }
          </th>
          <th>Description</th>
          <th>Price
            { isEditMode && <span>*</span> }
          </th>
          <th>Status
            { isEditMode && <span>*</span> }
          </th>
          <th>Calculate
            { isEditMode && <span>*</span> }
          </th>
          { !isEditMode && <th>Created at</th> }
          { !isEditMode && <th>Updated at</th> }
        </tr>
      </thead>
    )
  }
}
