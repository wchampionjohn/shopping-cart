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

      it "Add more same items to cart, but item count won't change" do
        1.times { cart.add_item(1) }
        2.times { cart.add_item(2) }
        3.times { cart.add_item(3) }

        expect(cart.items.length).to be 3
        expect(cart.items.first.quantity).to be 1
        expect(cart.items.second.quantity).to be 2
        expect(cart.items.last.quantity).to be 3
      end

    end
  end

end
