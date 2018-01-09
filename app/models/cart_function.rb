class CartFunction < ApplicationRecord

  has_many :special_products, class_name: 'SpecialProduct'
  has_many :rules, class_name: 'CostRule'
  has_one :setting, class_name: 'DiscountSetting'
  has_many :gifts
  has_many :additions

  accepts_nested_attributes_for :setting
  accepts_nested_attributes_for :rules

  def detail
    case name
    when 'special'
      special_products
    when 'gift'
      gifts
    when 'additional'
      additions
    end
  end

  def stuff cart
    send("stuff_#{name}".to_sym, cart)
  end

  def stuff_discount cart
    if setting.is_opening?
      discount = if setting.percent?
                   setting.percent_off
                 elsif setting.cut?
                   setting.offer
                 end
      cart.set_discount(setting.condition, discount, setting.discount_type.to_sym)
    end
  end

  def stuff_costs cart
    CostRule.opening_rules.each do |rule|
      cart.set_costs(rule.cost, rule.reach) if rule.is_opening?
    end
  end

  def stuff_special cart
    special_products.each do |special|
      activity = special.activity
      if activity.present?
        cart.set_special(special.product_id, activity[:offer], activity[:type])
      end
    end
  end

  def stuff_gift cart
    gifts.each do |gift|
      if !gift.is_limiting?
        gift.products.each do |product|
          cart.set_gift(gift.purchase_product_id, product.id)
        end
      end
    end
  end

  def stuff_additional cart
    additions.each do |addition|
      if !addition.is_limiting?
        addition.addition_products.each do |addition_product|
          cart.set_additional(addition.purchase_product_id, addition_product.product_id, addition_product.price)
        end
      end
    end
  end

end
