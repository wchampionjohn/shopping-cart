class CartFunction < ApplicationRecord


  has_many :rules, class_name: 'CostRule'
  has_one :setting, class_name: 'DiscountSetting'

  accepts_nested_attributes_for :setting

end
