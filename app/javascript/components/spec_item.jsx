export default class Item extends React.Component {
  render() {

    return (
      <div className="row">
        <div className="col-md-9">
          <label className="control-label"></label>
          <input
            type="text"
            className="form-control"
            name={"product[specs_attributes][][name]"}
            value={this.props.name || ''}
            onChange={this.props.change(this.props.index)} />
          <input
            type="hidden"
            name="product[specs_attributes][][id]"
            value={this.props.id || ''} />
        </div>
        {this.props.index > 0 &&
          <div className="col-md-1">
            <label className="control-label"></label>
            <button
              type="button"
              className="btn btn-danger"
              onClick={() => {this.props.remove(this.props.index)}}>
              <i className="fa fa-close"></i>
            </button>
          </div>
        }
        <br />
      </div>
    )
  }
}
