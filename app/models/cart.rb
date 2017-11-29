class Cart

  def initialize init_items = {}
    @storage = ::CartStorage.new # 抽離session
    @dao = ::CartDao.new # 抽離database
    @plugins = {}

    init_items.each do |item|
      add_item(item[:id], item[:quantity])
    end
  end

  def set_dao dao
    @dao = dao
  end

  def set_storage storage
    @storage = storage
  end

  def register_plugin name
    plugin_name =  '::CartPlugin' + name.capitalize

    raise ArgumentError.new("找不到plugin") unless Object.const_defined? plugin_name

    plugin_obj = plugin_name.constantize.new self

    if plugin_obj.respond_to? :get_value
      self.class.redefine_method("get_#{name}") do
        plugin_obj.get_value
      end
    end

    if plugin_obj.respond_to? :set_value
      self.class.redefine_method("set_#{name}") do |*args|
        plugin_obj.set_value(*args)
      end
    end

    @plugins[name] = plugin_obj
  end

  def plugin_exists? name
    @plugins[name].present?
  end

  def add_item(product_id, quantity = 1)

    raise ArgumentError.new("找不到此商品") unless @dao.exists? product_id

    @plugins.values.each do |plugin|
      plugin.before_add_item product_id
      plugin.before_refresh_item product_id
    end

    new_item = { id: product_id, quantity: quantity }

    item = @storage[product_id]

    @storage[product_id] = if item.nil?
                             new_item
                           else
                             item[:quantity] += new_item[:quantity]
                             item
                           end

    @plugins.values.each do |plugin|
      plugin.after_add_item product_id # triggle plugins after_add_item event
      plugin.after_refresh_item product_id # triggle plugins after_refresh_item event
    end
  end

  def update_quantity(product_id, quantity)
    @plugins.values.each do |plugin|
      plugin.before_update_item product_id
      plugin.before_refresh_item product_id
    end

    item = @storage[product_id]
    item[:quantity] = quantity

    @plugins.values.each do |plugin|
      plugin.after_update_item product_id
      plugin.after_refresh_item product_id
    end
  end

  def remove_item product_id
    @plugins.values.each do |plugin|
      plugin.before_remove_item product_id
      plugin.before_refresh_item product_id
    end

    @storage.delete product_id

    @plugins.values.each do |plugin|
      plugin.after_remove_item product_id
      plugin.after_refresh_item product_id
    end
  end

  def items
    @storage.items.map do |item|
      OpenStruct.new(
        id: item[:id],
        quantity: item[:quantity],
        product: @dao.find(item[:id])
      )
    end
  end

  def empty?
    @storage.empty?
  end

end
