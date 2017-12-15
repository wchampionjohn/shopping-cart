class CostRule < ApplicationRecord

  include Limitable

  validates :reach, :cost,
    presence: true,
    numericality: { only_integer: true }
  validate :cost_is_less_than_reach

  belongs_to :cart_function

  def self.opening_rules date = Date.today
    order("cost DESC").select{ |rule| rule.is_opening? date }
  end

  def is_opening? date = Date.today
    cart_function.is_open && # 運費功能開放
      is_open && # 規則開放
      !is_limiting?(date) # 不在限制時間內
  end

private
  def cost_is_less_than_reach
    errors.add(:cost, "運費不能高於滿額條件") if cost > reach
  end

end
