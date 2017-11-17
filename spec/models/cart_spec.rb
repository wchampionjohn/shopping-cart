require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }


  describe "add or get item from cart" do
    it "can create Cart" do
    end

    context "can add item" do
      it "Add a item to cart, then the cart won't be empty." do
        expect(cart).to be_empty
        cart.add_item(1)
        expect(cart).not_to be_empty
      end
    end
  end

end
