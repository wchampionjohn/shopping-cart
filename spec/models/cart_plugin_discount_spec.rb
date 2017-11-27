require 'rails_helper'

RSpec.describe CartPluginDiscount, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    CartPluginTotal
    cart.register_plugin('total')
    cart.register_plugin('discount')

    cart
  end

  describe "discount if above condtion" do
    it "滿額折X元" do
      # set discount rule : over 1000 and 100 cut off
      cart.set_discount(1000, 100, :cut)
      p1 = create(:product, price: 100)
      p2 = create(:product, price: 200)

      4.times {
        cart.add_item p1.id # 400
        cart.add_item p2.id # 800
      }

      expect(cart.get_total).to be 1100 # 1200 - 100
      cart.add_item p1.id # + 100
      expect(cart.get_total).to be 1200 # 再測一次，確認沒有重複扣
    end

    it "滿額X% off" do
      # set discount rule : over 2000 and 20 percent discount
      cart.set_discount(3000, 20, :percent)

      p1 = create(:product, price: 1000)
      p2 = create(:product, price: 2000)

      cart.add_item(p1.id)
      cart.add_item(p2.id)

      expect(cart.get_total).to be 2400 # 3000 - (3000 * 0.2) = 2400
    end
  end


end
