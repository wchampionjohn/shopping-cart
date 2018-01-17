class CostRule < ApplicationRecord

  include Limitable

  validates :reach, :cost,
    presence: true,
    numericality: { only_integer: true }

  belongs_to :cart_function

  after_initialize :default_values

  def default_values
    self.cart_function = CartFunction.find_by_name('costs')
  end

  def self.opening_rules date = Date.today
    order("cost DESC").select{ |rule| rule.is_opening? date }
  end

  def is_opening? date = Date.today
    cart_function.is_open && # 運費功能開放
      is_open && # 規則開放
      !is_limiting?(date) # 不在限制時間內
  end

end
