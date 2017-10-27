import React, { Component } from "react";
import ReactDOM from "react-dom";
import Pagination from 'react-js-pagination'

export default class Page extends Component {
  constructor(props) {
    super(props);
    this.state = {
      activePage: props.current_page
    };
  }


  onSwitchPage = (pageNumber) => {
    this.setState({activePage: pageNumber})
    this.props.onSwitchPage(pageNumber)
  }

  render() {

    const { pagination } = this.props

    return (
        <Pagination
          activePage={this.state.activePage}
          itemsCountPerPage={pagination.per_page}
          totalItemsCount={pagination.total_count}
          pageRangeDisplayed={5}
          onChange={this.onSwitchPage}
        />
    );
  }
}
