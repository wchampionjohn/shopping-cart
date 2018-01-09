# reference https://www.slideshare.net/jaceju/ss-6312192
class Cart

  def initialize init_items = {}
    @storage = ::CartStorage.new # 抽離session
    @dao = ::CartDao.new # 抽離database
    @plugins = {}

    init_items.each do |item|
      add_item(item['key'], item['quantity'])
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

  def add_item(key, quantity = 1)
    key = key.to_s
    id =  key.split('-')[0]

    raise ArgumentError.new("找不到此商品") unless @dao.exists? key

    @plugins.values.each do |plugin|
      plugin.before_add_item id
      plugin.before_refresh_item id
    end

    new_item = { id: id, key: key, quantity: quantity }

    item = @storage[key]

    @storage[key] = if item.nil?
                             new_item
                           else
                             item[:quantity] += new_item[:quantity]
                             item
                           end

    @plugins.values.each do |plugin|
      plugin.after_add_item id # triggle plugins after_add_item event
      plugin.after_refresh_item id # triggle plugins after_refresh_item event
    end
  end

  def update_quantity(key, quantity)
    key = key.to_s
    id =  key.split('-')[0]

    @plugins.values.each do |plugin|
      plugin.before_update_item id
      plugin.before_refresh_item id
    end

    item = @storage[key]
    item[:quantity] = quantity

    @plugins.values.each do |plugin|
      plugin.after_update_item id
      plugin.after_refresh_item id
    end
  end

  def remove_item key
    key = key.to_s
    id =  key.split('-')[0]

    @plugins.values.each do |plugin|
      plugin.before_remove_item id
      plugin.before_refresh_item id
    end

    @storage.delete key

    @plugins.values.each do |plugin|
      plugin.after_remove_item id
      plugin.after_refresh_item id
    end
  end

  def items
    @storage.items.map do |item|
      OpenStruct.new(
        key: item[:key],
        id: item[:key].split('-')[0],
        quantity: item[:quantity].to_i,
        product: @dao.find(item[:key])
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
