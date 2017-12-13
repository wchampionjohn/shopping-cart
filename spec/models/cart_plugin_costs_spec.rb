require 'rails_helper'

RSpec.describe CartPluginCosts, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    cart.register_plugin('total')
    # 注意順序(會影響運費門檻計算)
    cart.register_plugin('discount')
    cart.register_plugin('costs')

    cart
  end

  let(:p1) { create(:product, price: 100) }
  let(:p2) { create(:product, price: 200) }

  describe "calculate shipping cost" do
    it "只設定運費，不管消費多少錢都會產生同樣運費" do
      # set cost rule : base shipping cost 80 dollars
      cart.set_costs(80)

      cart.add_item p1.id # 100
      cart.add_item p2.id # 200

      expect(cart.get_costs).to be 80
      cart.add_item p2.id # 200
      expect(cart.get_costs).to be 80
    end

    it "設定多個運費，達到不同總額門檻時會有不同運費產生" do
      #
      cart.set_costs(80)
      cart.set_costs(60, 299)
      cart.set_costs(30, 599)
      cart.set_costs(0, 999)

      cart.add_item(p2.id)
      expect(cart.get_costs).to be 80

      cart.add_item(p1.id)
      expect(cart.get_costs).to be 60

      cart.add_item(p2.id)
      cart.add_item(p2.id)
      expect(cart.get_costs).to be 30

      cart.add_item(p2.id)
      cart.add_item(p2.id)
      expect(cart.get_costs).to be 0

      cart.remove_item p2.id
      expect(cart.get_costs).to be 80
    end

  end

  describe "運費規則與其他優惠方案並存" do
    it "滿額折扣跟運費規則並存時，運費規則會根據折扣完的價格來段有沒有到運費門檻" do
      cart.set_costs(90)
      cart.set_costs(60, 299)
      cart.set_discount(300, 10, :percent)

      3.times { cart.add_item(p1.id) } # total = 100 * 3 * 0.9

      expect(cart.get_costs).to be 90 # 折扣後會變成270，未達滿299門檻

      cart.add_item(p1.id)
    end
  end
end
