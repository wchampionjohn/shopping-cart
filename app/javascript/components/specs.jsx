import SpecItem from './spec_item'

export default class Specs extends React.Component {
  constructor(props){
    super(props);
    let items = []

    items = this.props.items.map(item =>
                                 (item.name === "" && item.id)
                                 ? { ...item, _destroy: true }
                                 : item
                                )

    this.state = {
      items: items
    }
  }

  handleAdd = () => {
    let item = { id: "", index: this.state.items.length + 1, name: "" }
    this.state.items.push(item)
    this.setState({ items: this.state.items })
  }

  handleRemove(delIndex){
    let items = this.state.items.map((item, index) => {
      if(delIndex !== index) {
        return item
      } else {
        return { ...item, _destroy: true }
      }
    })

    this.setState({items: items})
  }

  handleChange = (idx) => (evt) => {
    const newItems = this.state.items.map((item, sidx) => {
      if (idx !== sidx) return item;
      return { ...item, name: evt.target.value };
    });

    this.setState({ items: newItems });
  }

  renderDestroyInput = (id, index) => {
    return (
      <div key={index}>
      <input type="hidden" name="product[specs_attributes][][id]" value={id} />
      <input type="hidden" name="product[specs_attributes][][name]" value=""  />
      <input type="hidden" name="product[specs_attributes][][_destroy]" value={true} />
    </div>
    )
  }

  renderItems() {
    return this.state.items.map((item, index) =>
                                (item._destroy)
                                ? this.renderDestroyInput(item.id, index)
                                : <SpecItem
                                  key={index}
                                  index={index}
                                  id={item.id}
                                  name={item.name}
                                  remove={this.handleRemove.bind(this)}
                                  change={this.handleChange.bind(this)}
                                  />

                       )
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
            <a href="javascript:;" className="btn btn-info mt-repeater-add" onClick={this.handleAdd}>
              <i className="fa fa-plus"></i> 新增其他規格
            </a>
            <br />
            <br />
          </div>
        </div>
      </div>
    )
  }
}
