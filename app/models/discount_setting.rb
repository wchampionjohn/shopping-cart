class DiscountSetting < ApplicationRecord

  validates :condition,
    presence: true,
    numericality: { only_integer: true }
  validates :offer,
    numericality: { only_integer: true }
  validates_inclusion_of :percent_off, in: 1..100
  validate :offer_is_less_than_condition
  validate :limited_period

  belongs_to :cart_function

  enum discount_type: [:cut, :percent]

  def is_open? date
    return false if !cart_function.is_open

    !is_limited || is_limited_period?(date)
  end

  def is_limited_period? date
    date.between?(limited_start_date, limited_end_date)
  end

private
  def offer_is_less_than_condition
    errors.add(:offer, "折除金額不能大於滿額條件") if offer > condition
  end

  def limited_period
    if is_limited && limited_start_date.blank? || limited_end_date.blank?
      errors.add(:limited_start_date, :blank) if limited_start_date.blank?
      errors.add(:limited_end_date, :blank) if limited_end_date.blank?
    end
  end

end
