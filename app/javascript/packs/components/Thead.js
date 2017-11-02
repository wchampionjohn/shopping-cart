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
          <th>名稱
            { isEditMode && <span>*</span> }
          </th>
          <th>商品描述</th>
          <th>價格
            { isEditMode && <span>*</span> }
          </th>
          <th>商品保存狀態
            { isEditMode && <span>*</span> }
          </th>
          <th>數量
            { isEditMode && <span>*</span> }
          </th>
          { !isEditMode && <th>最後更新</th> }
          { !isEditMode && <th>建立時間</th> }
        </tr>
      </thead>
    )
  }
}
