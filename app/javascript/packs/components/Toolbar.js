import React, { Component } from 'react'
import PropTypes from 'prop-types'

export default class Toolbar extends Component {

  handleSearch = e => {
    this.props.onSearch(e.target.value)
  }

  handleRefresh = () => {
    this.setState({ keyword: '' })
    this.props.clearKeyword()
    this.props.fetchPosts()
  }

  handleChange = e => {
    this.setState({ keyword: e.target.value })
  }

  handleSwitchEditMode = () => {
    this.props.onSwitchEditMode()
    this.props.onSetEditingProducts()
  }

  handleCancelSave = () => {
    this.props.onCloseEditMode()
  }

  handleDelete = ids => {
    var isSure = confirm('Are you sure want to delete this data?');

    if(isSure) {
      this.props.onDeleteProducts(ids)
      toastr.success('刪除成功', 'Success');
    }
  }

  renderEditButton = () => {

    if(!this.props.isEditMode) {
      return (
        <button
          disabled={!this.isSelectedProudcts()}
          className="btn btn-default"
          onClick={this.handleSwitchEditMode}
          type="buttton" >
          <i className="glyphicon glyphicon-pencil"></i>
        </button>
      )
    }
  }

  renderTrushButton = () => {

    if(!this.props.isEditMode) {
      return (
        <button
          disabled={!this.isSelectedProudcts()}
          className="btn btn-default"
          onClick={() => this.handleDelete(this.props.selectedProductIds)}
          type="buttton" >
          <i className="glyphicon glyphicon glyphicon-trash" alt="刪除"></i>
        </button>
      )
    }
  }

  renderSaveButton = () => {

    const { isEditMode } = this.props

    if(isEditMode) {
      return (
        <button
          onClick={this.props.onSaveProducts}
          className="btn btn-default"
          type="buttton">
          <i className="glyphicon glyphicon-floppy-disk" alt="確認修改"></i>
        </button>
      )
    }
  }

  renderCancelSaveButton = () => {

    const { isEditMode } = this.props

    if(isEditMode) {
      return (
        <button
          onClick={this.props.onCloseEditMode}
          className="btn btn-default"
          type="buttton">
          <i className="glyphicon glyphicon-floppy-remove" alt="取消修改"></i>
        </button>
      )
    }
  }

  isSelectedProudcts = () => {
    const { selectedProductIds } = this.props
    return selectedProductIds.length !== 0
  }

  state = {
    keyword: ''
  }

  render() {

    return (
      <div className="table-toolbar">
        <div className="btn-group pull-left">
          <a href="products/new" className="btn blue"> <i className="glyphicon glyphicon glyphicon-plus"></i> </a>
        </div>
        <div className="btn-group pull-right">
          <button
            className="btn btn-default"
            type="buttton"
            name="refresh"
            title="Refresh"
            onClick={this.handleRefresh}>
            <i className="glyphicon glyphicon-refresh icon-refresh"></i>
          </button>
          { this.renderEditButton() }
          { this.renderSaveButton() }
          { this.renderCancelSaveButton() }
          { this.renderTrushButton() }
        </div>

        <div className="pull-right search">
          <input
            className="form-control"
            type="text"
            placeholder="Search"
            title="Please enter description or title to search"
            onKeyUp={this.handleSearch}
            value={this.state.keyword}
            onChange={this.handleChange}
          />
        </div>
      </div>
    )

  }
}
