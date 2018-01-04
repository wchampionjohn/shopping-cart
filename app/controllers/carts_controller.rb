class CartsController < ApplicationController
  include CartsHelper
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def checkout
    @cart = current_cart
    @currnet_gifts = format_gifts @cart.get_gift if @cart.plugin_exists? 'gift'
    @discount_setting = CartFunction.find_by_name('discount').setting
    @opening_rules = CostRule.opening_rules
  end

  def add
    id = params[:id]
    current_cart.add_item id
    params[:addition_ids].each { |id| current_cart.add_item(id) } if params[:addition_ids].present?
    @title = Product.find(id).title
    save_to_session
    render :layout => false
  end

  def remove
    current_cart.remove_item params[:id]
    flash[:notice] = '已從購物車移除'
    save_to_session
    redirect_to checkout_cart_path
  end

  def clear
    current_cart.clear
    save_to_session
    flash[:notice] = '已從清空購物車內所有商品'
    redirect_to checkout_cart_path
  end

  def update_quantity
    # TODO 試看看用service object 重構
    product = Product.find params[:id]
    quantity = params[:quantity].to_i
    cart = current_cart

    raise '數量必須為數字' if quantity == 0

    if product.remain < params[:quantity].to_i
      raise '商品數量不足'
    end

    cart.update_quantity(params[:id], params[:quantity])
    item = cart.items.find { |item| item.id.to_i == params[:id].to_i }
    amount = calculate_amount(cart, item)
    additions_amount = recalculate_additions(cart, item)
    save_to_session

    render json: {
      origin: currency(cart.get_total.origin),
      total: currency(cart.get_total.special),
      amount: currency(amount),
      additions_amount: additions_amount,
      costs: currency(cart.get_costs),
      discount: cart.get_discount
    }, status: :ok

  rescue Exception => msg
    item = cart.items.find { |item| item.id.to_i == params[:id].to_i }
    render json: { message: msg, quantity: item.quantity }, status: 400
  end

  private
  def save_to_session
    session[:cart] = current_cart.items.map do |item|
      {
        id: item.id,
        quantity: item.quantity
      }
    end
  end

  def format_gifts cart_gifts
    cart_gifts.reduce({}) do |result, (key, id)|
      result[key] = Product.select(:title).where(id: id).map(&:title)
      result
    end
  end

end
