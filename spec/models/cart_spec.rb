require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }


  describe "add or get item from cart" do
    it "can create Cart" do
    end

    context "can add item" do
      let(:iphone) { create(:product, :iphone) }
      it "Add a item to cart, then the cart won't be empty." do
        cart.add_item(iphone)
        cart.items.first to be iphone
      end
    end
  end

end
