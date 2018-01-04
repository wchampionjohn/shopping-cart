export default class Item extends React.Component {

  renderProductSelect = (selected, item_index) => {
    const options = this.props.options.map((option, index) => (
      <option key={index} value={option[0]} >{option[1]}</option>
    ))

    return (
      <select
        className="form-control select "
        name="addition[addition_products_attributes][][product_id]"
        value={selected}
        onChange={this.props.change(item_index, 'product_id')}>
        { options }
      </select>
    )
  }
  render() {


    const {
      index,
      id,
      product,
      change,
      remove,
      showTitle,
      errors,
      options
    } = this.props

    return (
      <div className="row">
        <div className={"col-md-9 " + ((errors && errors['product']) ? 'has-error' : '')}>
          <label className="control-label">* 商品名稱</label>
          { this.renderProductSelect(product.product_id, index) }
          <input
            type="hidden"
            name="addition[addition_products_attributes][][id]"
            value={product.id || ''} />
          {errors !== undefined && <span className="help-block">{errors['product']}</span>}
        </div>
        <div className={"col-md-2 " + ((errors && errors['price']) ? 'has-error' : '')}>
          <label className="control-label">* 加購價 </label>
          <input
            type="text"
            className="form-control integer"
            type="number"
            name="addition[addition_products_attributes][][price]"
            min="1"
            value={product.price}
            onChange={change(index, 'price')}
          />
          {errors !== undefined && <span className="help-block">{errors['price']}</span>}
        </div>

        {(index != 0) &&
          <div className="col-md-1">
            <label className="control-label">&nbsp;&nbsp;&nbsp;</label>
              <button
                type="button"
                className="btn btn-danger sm-btn"
                onClick={() => {remove(index)}}>
                <i className="fa fa-close"></i>
              </button>
            </div>
        }
      </div>
    )
  }
}
