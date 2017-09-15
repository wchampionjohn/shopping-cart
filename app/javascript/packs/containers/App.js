import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Toolbar from '../components/ToolBar'
import Table from '../components/Table'
import { fetchPosts } from '../actions'

class App extends Component {

  componentDidMount() {
    const { dispatch, products } = this.props
    dispatch(fetchPosts())
  }

  render() {

    const { dispatch, products } = this.props

    return (
      <div>
        <Toolbar />
        <Table products={products} />
      </div>
    )
  }
}

const mapStateToProps = state => ({
  products: state.products
})

export default connect(
  mapStateToProps
)(App)
