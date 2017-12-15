class Admin::CostsController < ApplicationController
  include ApplicationHelper

  def index
    @function = CartFunction.find_by_name('costs')
    @rules = @function.rules.where.not(id: nil).order("is_open DESC").order("cost DESC")
    @opening_rules = CostRule.opening_rules
  end

  def update
    function = CartFunction.find(params[:id])
    is_add_rule = params[:is_add_rule]

    if function.update(stronge_params(is_add_rule))
      flash[:success] = '更新成功'
      redirect_to admin_costs_path
    else
      @function = function
      @rules = @function.rules.where.not(id: nil).order("is_open DESC").order("cost DESC")
      @current_rule = function.rules.find{ |rule| rule.new_record? }
      @opening_rules = CostRule.opening_rules
      @is_add_rule = is_add_rule
      flash[:alert] = '更新失敗'
      render action: :index
    end
  end

  def switch
    rule = CostRule.find params[:id]
    rule.update(is_open: !rule.is_open)
    render json: { summary: costs_summary(CostRule.opening_rules) }, status: :ok
  end

  def destroy
    CostRule.find(params[:id]).destroy
    flash[:success] = '刪除成功'
    redirect_to admin_costs_path
  end

  def stronge_params is_add_rule
    rules_attributes = { rules_attributes: [:id,
                                            :reach,
                                            :cost,
                                            :is_open,
                                            :offer,
                                            :is_limited,
                                            :limited_start_date,
                                            :limited_end_date] }

    if is_add_rule == '1'
      params.require(:cart_function).permit(:is_open, :memo, rules_attributes)
    else
      params.require(:cart_function).permit(:is_open, :memo)
    end
  end
end
