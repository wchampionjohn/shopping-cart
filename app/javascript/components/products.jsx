import ProductItem from './product_item'

export default class Products extends React.Component {
  constructor(props){
    super(props);
    let items = []

    if (this.props.items.length == 0) {
      const item = this.newItem()
      items.push(item)
    } else {
     items = this.props.items.map(item =>
                                       (item.product_id === null && item.price === null && item.id) // server驗證沒過時還原已刪除的item
                                       ? { ...item, _destroy: true }
                                       : item
                                      )
    }

    this.state = {
      items: items
    }
  }

  newItem = () => {
    return { product_id: "", price: null }
  }

  handleAdd = () => {
    const item = this.newItem()
    const items = [ ...this.state.items, item]

    this.setState({ items: items })
  }

  handleRemove(delIndex){
    let items = this.state.items.map((item, index) => {
      if(delIndex !== index) {
        return item
      } else {
        return { ...item, _destroy: true, product_id: null, price: null }
      }
    })

    // 清除新增後又刪除遺留空item
    items = items.filter(function(item){
      return (!item._destroy || item.id !== "")
    })

    this.setState({items: items})
  }

  handleChange = (idx, column) => (e) => {
    const newItems = this.state.items.map((item, sidx) => {
      if (idx !== sidx){
        return item;
      } else {
        return { ...item, [column] : e.target.value };
      }
    });

    this.setState({ items: newItems });
  }

  renderDestroyInput = (item, index) => {
    return (
      <div key={index}>
      <input type="hidden" name="addition[addition_products_attributes][][id]" value={item.id} />
      <input type="hidden" name="addition[addition_products_attributes][][product_id]" value={item.product_id} />
      <input type="hidden" name="addition[addition_products_attributes][][price]" value={item.price} />
      <input type="hidden" name="addition[addition_products_attributes][][_destroy]" value={true} />
    </div>
    )
  }

  renderItems() {
      return this.state.items.map((item, index) => {
                                  if (item._destroy) {
                                    return this.renderDestroyInput(item, index);
                                  } else {
                                    return <ProductItem
                                      key={index}
                                      index={index}
                                      product={item}
                                      errors={this.props.errors[index]}
                                      options={this.props.options}
                                      remove={this.handleRemove.bind(this)}
                                      change={this.handleChange.bind(this)}
                                    />;
                                  }
      })
  }

  render() {

    return (
      <div className="form-group">
        <label className="col-md-2 control-label">
          <br />
          * 加購商品
        </label>
        <div className="col-md-10">
          <div className="mt-repeater">
            {this.renderItems()}
            <hr />
            <button type="button" className="btn btn-info mt-repeater-add" onClick={this.handleAdd}>
              <i className="fa fa-plus"></i> 新增
            </button>
            <br />
            <br />
          </div>
        </div>
      </div>
    )
  }
}
