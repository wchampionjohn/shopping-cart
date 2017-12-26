# 限制開放的
module Limitable
  extend ActiveSupport::Concern

  included do
    validate :limited_period
  end

  # date(日期)正被限制開放中
  def is_limiting? date = Date.today
    is_limited && !is_limited_period?(date) # 是限時開放且date不在開放期間
  end

  def is_limited_period? date
    date.between?(limited_start_date, limited_end_date)
  end

private

  def limited_period
    if is_limited && (limited_start_date.blank? || limited_end_date.blank?)
      errors.add(:limited_start_date, :blank) if limited_start_date.blank?
      errors.add(:limited_end_date, :blank) if limited_end_date.blank?
    end
  end
end
