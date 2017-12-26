class Admin::DiscountSettingsController < ApplicationController
  def index
    @function = CartFunction.find_by_name 'discount'
  end

  def update
    function = CartFunction.find(params[:id])

    if function.update(stronge_params)
      flash[:success] = '更新成功'
      redirect_to admin_discount_settings_path
    else
      @function = function
      flash[:alert] = '更新失敗'
      render action: :index
    end
  end

  def stronge_params
    params.require(:cart_function)
          .permit(:is_open, :memo,
                   setting_attributes: [:id,
                                        :condition,
                                        :discount_type,
                                        :percent_off,
                                        :offer,
                                        :is_limited,
                                        :limited_start_date,
                                        :limited_end_date]
                 )
  end
end
