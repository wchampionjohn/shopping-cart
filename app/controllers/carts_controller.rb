class CartsController < ApplicationController
  include CartsHelper
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def checkout
    @cart = current_cart
  end

  def add
    current_cart.add_item params[:id]
    @title = Product.find(params[:id]).title
    save_to_session
    render :layout => false
  end

  def remove
    current_cart.remove_item params[:id]
    flash[:notice] = '已從購物車移除'
    save_to_session
    redirect_to checkout_cart_path
  end

  def update_quantity
    product = Product.find params[:id]
    quantity = params[:quantity].to_i
    cart = current_cart

    raise '數量必須為數字' if quantity == 0

    if product.remain <= params[:quantity].to_i
      item = cart.items.find { |item| item.id.to_i == params[:id].to_i }
      raise '商品數量不足'
    end

    cart.update_quantity(params[:id], params[:quantity])
    item = cart.items.find { |item| item.id.to_i == params[:id].to_i }
    save_to_session
    amount = item.product.price * item.quantity

    render json: { total: currency(cart.get_total.origin), amount: currency(amount) }, status: :ok

  rescue Exception => msg
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
end
