class DiscountSetting < ApplicationRecord

  include Limitable

  validates :condition,
    presence: true,
    numericality: { only_integer: true }
  validates :offer,
    numericality: { only_integer: true }
  validates_inclusion_of :percent_off, in: 1..100
  validate :offer_is_less_than_condition

  belongs_to :cart_function

  enum discount_type: [:cut, :percent]

  def is_opening? date = Date.today
    cart_function.is_open && !is_limiting?(date) # 功能開放且設定不在限制中
  end

private
  def offer_is_less_than_condition
    errors.add(:offer, "折除金額不能大於滿額條件") if offer > condition
  end

end
