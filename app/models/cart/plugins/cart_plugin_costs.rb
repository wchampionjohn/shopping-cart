# 運費規則
class CartPluginCosts < CartPlugin

  def initialize cart
    @cart = cart
    @rules = []
  end

  def after_refresh_item item_key
    total_price = @cart.get_total.special

    after_sort_rules = @rules.sort { |rule1, rule2| rule2[:condition] <=> rule1[:condition] }
    current_rule = after_sort_rules.find do |rule|
      total_price > rule[:condition] # 總金額大於運費條件
    end

    @current_costs = current_rule[:costs]
  end

  def get_value
    @current_costs
  end

  def set_value(*args)
    @rules.push(
      {
        costs: args.first, # 運費
        condition: args.try(:last).to_i # 滿足條件
      }
    )
  end
end
