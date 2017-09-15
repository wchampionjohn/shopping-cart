import React from 'react'
import PropTypes from 'prop-types'

const Thead = () => (
  <thead>
    <tr>
      <th className="ui-helper-center">
        <input type="checkbox" />
      </th>
      <th></th>
      <th>#</th>
      <th>Name<span>*</span></th>
      <th>Description</th>
      <th>Price<span>*</span></th>
      <th>Status<span>*</span></th>
      <th>Calculate<span>*</span></th>
      <th>Created at</th>
      <th>Updated at</th>
    </tr>
  </thead>
)

export default Thead
