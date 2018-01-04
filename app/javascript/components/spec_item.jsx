export default class Item extends React.Component {
  render() {

    const {
      index,
      id,
      spec,
      change,
      remove,
      showTitle,
      errors
    } = this.props

    return (
      <div className="row">
        <div className={"col-md-7 " + ((errors && errors['name']) ? 'has-error' : '')}>
          <label className="control-label">{ showTitle && '* 名稱'}&nbsp;</label>
          <input
            type="text"
            className="form-control"
            name={"product[specs_attributes][][name]"}
            value={spec.name || ''}
            onChange={change(index, 'name')} />
          <input
            type="hidden"
            name="product[specs_attributes][][id]"
            value={spec.id || ''} />
          {errors !== undefined && <span className="help-block">{errors['name']}</span>}
        </div>
        <div className={"col-md-2 " + ((errors && errors['quantity']) ? 'has-error' : '')}>
          <label className="control-label">{ showTitle && '* 數量'}&nbsp;</label>
          <input
            type="text"
            className="form-control integer"
            type="number"
            name="product[specs_attributes][][quantity]"
            min="1"
            value={spec.quantity || 1}
            onChange={change(index, 'quantity')}
          />
          {errors !== undefined && <span className="help-block">{errors['quantity']}</span>}
        </div>
        <div className="col-md-1">
        <label className="control-label">&nbsp;&nbsp;&nbsp;</label>
          <button
            type="button"
            className="btn btn-danger sm-btn"
            onClick={() => {remove(index)}}>
            <i className="fa fa-close"></i>
          </button>
        </div>
      </div>
    )
  }
}
