# reference https://www.slideshare.net/jaceju/ss-6312192
class Cart

  def initialize init_items = {}
    @storage = ::CartStorage.new # 抽離session
    @dao = ::CartDao.new # 抽離database
    @plugins = {}

    init_items.each do |item|
      add_item(item['id'], item['quantity'])
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

    begin
      plugin_obj = plugin_name.constantize.new self
    rescue NameError
      raise ArgumentError.new("找不到plugin #{plugin_name}")
    end

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

  def add_item(item_key, quantity = 1)
    item_key = item_key.to_s
    raise ArgumentError.new("找不到此商品") unless @dao.exists? item_key

    @plugins.values.each do |plugin|
      plugin.before_add_item item_key
      plugin.before_refresh_item item_key
    end

    new_item = { id: item_key, quantity: quantity }

    item = @storage[item_key]

    @storage[item_key] = if item.nil?
                             new_item
                           else
                             item[:quantity] += new_item[:quantity]
                             item
                           end

    @plugins.values.each do |plugin|
      plugin.after_add_item item_key # triggle plugins after_add_item event
      plugin.after_refresh_item item_key # triggle plugins after_refresh_item event
    end
  end

  def update_quantity(item_key, quantity)
    item_key = item_key.to_s
    @plugins.values.each do |plugin|
      plugin.before_update_item item_key
      plugin.before_refresh_item item_key
    end

    item = @storage[item_key]
    item[:quantity] = quantity

    @plugins.values.each do |plugin|
      plugin.after_update_item item_key
      plugin.after_refresh_item item_key
    end
  end

  def remove_item item_key
    item_key = item_key.to_s
    @plugins.values.each do |plugin|
      plugin.before_remove_item item_key
      plugin.before_refresh_item item_key
    end

    @storage.delete item_key

    @plugins.values.each do |plugin|
      plugin.after_remove_item item_key
      plugin.after_refresh_item item_key
    end
  end

  def items
    @storage.items.map do |item|
      OpenStruct.new(
        id: item[:id],
        quantity: item[:quantity].to_i,
        product: @dao.find(item[:id])
      )
    end
  end

  def empty?
    @storage.empty?
  end

  def clear
    @storage = ::CartStorage.new
  end

end
