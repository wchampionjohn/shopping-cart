require 'rails_helper'

RSpec.describe CartPluginSpecial, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    CartPluginTotal
    CartPluginDiscount
    cart.register_plugin('special')
    cart.register_plugin('total')
    cart.register_plugin('discount')

    cart
  end

  let(:p1) { create(:product, price: 100) }
  let(:p2) { create(:product, price: 200) }

  describe "special offer" do
    it "指定商品折X元" do
      # set special offer rule : proudct 1 cut off 10 dollar
      cart.set_special(p1.id, 10, :cut)

      4.times do
        cart.add_item p1.id # 360
        cart.add_item p2.id # 800
      end

      expect(cart.get_total).to be 1160 # 360 + 800
      cart.add_item p1.id # + 90
      expect(cart.get_total).to be 1250
    end

    it "指定商品X% off" do
      # set special offer rule : proudct 1 cut off 20 percent
      cart.set_special(p1.id, 20, :percent) # 100 - 20% = 80

      3.times { cart.add_item(p1.id) } # 80  * 3 = 240
      2.times { cart.add_item(p2.id) } # 200 * 2 = 400

      expect(cart.get_total).to be 640
    end

    it "指定商品X元" do
      # set special offer rule : proudct 1 120 dollar
      cart.set_special(p2.id, 120, :offer)

      5.times { cart.add_item(p1.id) } # 100 * 5 = 500
      3.times { cart.add_item(p2.id) } # 120 * 3 = 360

      expect(cart.get_total).to be 860
    end
  end

  describe "指定商品特價 + 滿額特價" do
    it "指定商品折20，滿1000再減20%" do
      cart.set_special(p1.id, 20, :cut) # (100 - 20) = 80
      cart.set_discount(1000, 20, :percent) # total_price * 0.8 if total_price > 1000
      14.times { cart.add_item(p1.id) }

      expect(cart.get_total).to be 896 # 14 * 80 * 0.8
    end

    it "指定商品減50%，滿400再減10%" do
      cart.set_special(p1.id, 40, :percent) # (100 * 60) = 60
      cart.set_discount(400, 10, :percent) # total_price * 0.9 if total_price > 400
      8.times { cart.add_item(p1.id) }

      expect(cart.get_total).to be 432 # 8 * 60 * 0.9
    end
  end

end
