require 'rails_helper'

RSpec.describe CartPluginTotal, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    cart.register_plugin('total')
    cart
  end

  describe "calculator" do
    it "calculate total price of this cart" do
      p1 = create(:product, price: 100)
      p2 = create(:product, price: 200)

      3.times {
        cart.add_item(p1.id) # 300
        cart.add_item(p2.id) # 600
      }

      expect(cart.get_total).to be 900
    end
  end


end
