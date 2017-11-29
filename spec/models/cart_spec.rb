require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }

  describe "add or get item from cart" do
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

  describe "update quantity" do
    it "update cart item quantity" do
      5.times { cart.add_item(1) }
      expect(cart.items.first.quantity).to be 5
      cart.update_quantity(1, 3)
      expect(cart.items.first.quantity).to be 3
      cart.update_quantity(1, 1)
      expect(cart.items.first.quantity).to be 1
    end
  end

  describe "remove item" do
    it "remove cart item from exists items" do
      3.times { cart.add_item(1) }
      1.times { cart.add_item(2) }
      2.times { cart.add_item(3) }

      expect(cart.items.length).to be 3
      cart.remove_item 1
      expect(cart.items.length).to be 2
      cart.remove_item 2
      expect(cart.items.length).to be 1
    end
  end

  describe "add items to cart and rebuild cart from items" do
    context "cart to items" do
      it "get items structure after add items" do
        3.times { cart.add_item(2) }
        4.times { cart.add_item(5) }
        expect(cart.items).to eq build(:session_struct)
      end
    end

    context "items to cart" do
      it "rebuild cart from items structure" do
        cart = Cart.new(build(:session_struct))

        expect(cart.items.first.id).to be 2
        expect(cart.items.first.quantity).to be 3
        expect(cart.items.second.id).to be 5
        expect(cart.items.second.quantity).to be 4
      end
    end
  end

end
