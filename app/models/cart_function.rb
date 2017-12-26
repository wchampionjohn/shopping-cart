class CartFunction < ApplicationRecord

  has_many :special_products, class_name: 'SpecialProduct'
  has_many :rules, class_name: 'CostRule'
  has_one :setting, class_name: 'DiscountSetting'

  accepts_nested_attributes_for :setting
  accepts_nested_attributes_for :rules

  def stuff cart
    cart.register_plugin(name)
    send("stuff_#{name}".to_sym, cart)
  end

  # discount
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
end
