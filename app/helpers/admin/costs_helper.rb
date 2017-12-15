module Admin::CostsHelper

  def during_of_open rule

    return '永久' if !rule.is_limited
    return "#{rule.limited_start_date} 至 #{rule.limited_end_date}"

  end

end
