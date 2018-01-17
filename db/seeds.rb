# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
unless CartFunction.exists?
  CartFunction.create [
    { id: 1, title: '運費規則' ,    name: 'costs',      is_open: 1 },
    { id: 2, title: '滿額折價' ,    name: 'discount',   is_open: 1 },
    { id: 3, title: '指定商品特價', name: 'special',    is_open: 1 },
    { id: 4, title: '買A送B' ,      name: 'gift',       is_open: 1 },
    { id: 5, title: '商品加購' ,    name: 'additional', is_open: 1 }
  ]
end

unless Admin.find_by_email('vhitotoyouv@gmail.com').presence?
  Admin.create email: 'vhitotoyouv@gmail.com', password: 'yoyorock@0505'
end

unless Product.exists?

  Spec.delete_all
  Addition.delete_all
  AdditionProduct.delete_all
  CostRule.delete_all
  Gift.delete_all
  GiftProduct.delete_all
  SpecialProduct.delete_all

  CostRule.create reach: 0, cost: 100, is_open: 1, is_limited: 0 # 預設基本運費 100
  DiscountSetting.create condition: 10000, is_limited: 0, percent_off: 10, discount_type: :percent # 預設滿10000折%10

  seeds_product = YAML.load_file 'db/seeds/products.yml'

  seeds_product.each do |product|
    new_product = Product.new product.except(*['description', 'image_url' ])
    new_product.description  = product['description'].gsub(/\n/, '<br/><br/>')
    new_product.remote_image_path_url = product["image_url"]
    new_product.status = :all_new
    new_product.is_launched = 1
    new_product.save!
  end
end
