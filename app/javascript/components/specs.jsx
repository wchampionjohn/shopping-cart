import SpecItem from './spec_item'

export default class Specs extends React.Component {
  constructor(props){
    super(props);
    let items = []

    items = this.props.items.map(item =>
                                 (item.name === "" && item.id) // server驗證沒過時還原已刪除的item
                                 ? { ...item, _destroy: true }
                                 : item
                                )

    this.state = {
      items: items
    }
  }

  handleAdd = () => {
    const item = { id: "", index: this.state.items.length + 1, name: "", quantity: 1 }
    const items = [ ...this.state.items, item]

    const amount = items.reduce(function(result, item) {
      if(!item._destroy) {
        result += parseInt(item.quantity)
      }

      return result
    }, 0)

    this.setState({ items: items })

    disableCalculate()
    updateCalculate(amount)
  }

  handleRemove(delIndex){
    let items = this.state.items.map((item, index) => {
      if(delIndex !== index) {
        return item
      } else {
        return { ...item, _destroy: true, name: '' }
      }
    })

    // 清除新增後又刪除遺留空item
    items = items.filter(function(item){
      return (!item._destroy || item.id !== "")
    })

    this.setState({items: items})

    const activeItems = items.reduce(function(result, item){
      if(!item._destroy) {
        result.amount += parseInt(item.quantity)
        result.size += 1
      }
      return result
    }, {amount: 0, size: 0})

    if (activeItems.size == 0) {
      enableCalculate()
    }

    updateCalculate(activeItems.amount)
  }

  handleChange = (idx, column) => (e) => {
    const newItems = this.state.items.map((item, sidx) => {
      if (idx !== sidx){
        return item;
      } else {
        return { ...item, [column] : e.target.value };
      }
    });

    if (column == 'quantity') {
      const amount = newItems.reduce(function(result, item) {
        if(!item._destroy || item._destroy === undefined) {
          result += parseInt(item.quantity)
        }

        return result
      }, 0)

      updateCalculate(amount)

    }

    this.setState({ items: newItems });
  }

  renderDestroyInput = (item, index) => {
    return (
      <div key={index}>
      <input type="hidden" name="product[specs_attributes][][id]" value={item.id} />
      <input type="hidden" name="product[specs_attributes][][name]" value={item.name}  />
      <input type="hidden" name="product[specs_attributes][][_destroy]" value={true} />
    </div>
    )
  }

  renderItems() {
    let showTitle = true
    return this.state.items.map((item, index) => {

                                if (item._destroy) {
                                  return this.renderDestroyInput(item, index);
                                } else {
                                  const spec = <SpecItem
                                    key={index}
                                    showTitle={showTitle}
                                    index={index}
                                    spec={item}
                                    errors={this.props.errors[index]}
                                    remove={this.handleRemove.bind(this)}
                                    change={this.handleChange.bind(this)}
                                  />;
                                  showTitle = false
                                  return spec
                                }
    })
  }

  render() {

    return (
      <div className="form-group">
        <label className="col-md-2 control-label">
          <br />
          規格
        </label>
        <div className="col-md-10">
          <div className="mt-repeater">
            {this.renderItems()}
            <hr />
            <button type="button" className="btn btn-info mt-repeater-add" onClick={this.handleAdd}>
              <i className="fa fa-plus"></i> 新增其他規格
            </button>
            <br />
            <br />
          </div>
        </div>
      </div>
    )
  }
}
