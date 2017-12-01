require 'rails_helper'

RSpec.describe CartPluginTotal, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    cart.register_plugin('total')
    cart
  end

  let (:p1) { create(:product, price: 100) }
  let (:p2) { create(:product, price: 200) }

  before(:each) do
    3.times do
      cart.add_item(p1.id) # 300
      cart.add_item(p2.id) # 600
    end
  end

  describe "calculator" do
    it "calculate total price of this cart" do
      expect(cart.get_total.origin).to be 900
    end

    it "recalculate total price of this cart when this cart update quantity" do
      cart.update_quantity(p2.id, 5) # 1000
      expect(cart.get_total.origin).to be 1300 # 1000 + 300
    end

    it "recalculate total price of this cart when this cart remove item" do
      cart.remove_item p2.id
      expect(cart.get_total.origin).to be 300
    end
  end
end
