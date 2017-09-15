import React from 'react'
import PropTypes from 'prop-types'

const Toolbar = () => (
  <div className="btn-toolbar">
    <div className="pull-left btn-group btn-group-sm">
      <button className="btn btn-default" type="buttton" name="refresh" title="Refresh">
        <i className="glyphicon glyphicon glyphicon-plus"></i>
      </button>
    </div>
    <div className="pull-right btn-group btn-group-sm">
      <button className="btn btn-default" type="buttton" name="refresh" title="Refresh">
        <i className="glyphicon glyphicon-refresh icon-refresh"></i>
      </button>
      <button className="btn btn-default btn-xs" type="buttton">
        <i className="glyphicon glyphicon-pencil"></i>
      </button>
      <button className="btn btn-default btn-xs" type="buttton">
        <i className="glyphicon glyphicon-floppy-disk" alt="確認修改"></i>
      </button>
      <button className="btn btn-default btn-xs" type="buttton">
        <i className="glyphicon glyphicon-floppy-remove" alt="取消修改"></i>
      </button>
      <button className="btn btn-default btn-xs" type="buttton">
        <i className="glyphicon glyphicon glyphicon-trash" alt="刪除"></i>
      </button>
    </div>

    <div className="pull-right search">
      <input id="keyword" className="form-control input-sm" type="text" placeholder="Search" />
    </div>
  </div>
)

export default Toolbar
