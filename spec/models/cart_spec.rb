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

      it "item added to cart, get the item back from the cart." do
        iphone = create(:product, :iphone)
        ipad = create(:product, :ipad)

        cart.add_item(iphone.id)
        cart.add_item(ipad.id)

        expect(cart.items.first.id).to eq iphone.id
        expect(cart.items.last.id).to eq ipad.id
      end

    end
  end

end
