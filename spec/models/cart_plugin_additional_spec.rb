require 'rails_helper'

RSpec.describe CartPluginAdditional, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.set_dao CartDaoProduct.new # 從db找product
    cart.register_plugin('special')
    cart.register_plugin('additional')
    cart.register_plugin('total')

    cart
  end

  let(:p1) { create(:product, price: 100) }
  let(:p2) { create(:product, price: 200) }

  describe "商品加價購" do

    it "買A加購B就有X的加購價" do
      cart.set_additional(p2.id, p1.id, 80)
      cart.add_item(p2.id)
      cart.add_item(p1.id)

      expect(cart.get_total.origin).to be 280
    end

    it "先買B再買A時，B也會變為加購價" do
      cart.set_additional(p2.id, p1.id, 80)
      cart.add_item(p1.id)
      cart.add_item(p2.id)

      expect(cart.get_total.origin).to be 280
    end

    it "只買B不會有特價" do
      cart.set_additional(p2.id, p1.id, 80)
      cart.add_item(p1.id)

      expect(cart.get_total.origin).to be 100
    end

    it "買N件A只有N件B有加購價" do
      cart.set_additional(p2.id, p1.id, 80)
      cart.add_item(p2.id) # 200
      cart.add_item(p1.id) # 80
      cart.add_item(p1.id) # 100
      cart.add_item(p1.id) # 100
      expect(cart.get_total.origin).to be 480

      cart.update_quantity(p1.id, 2) # 180 (80 + 100)
      expect(cart.get_total.origin).to be 380

      cart.update_quantity(p2.id, 2) # p1有兩件可以有加購價
      expect(cart.get_total.origin).to be 560 # 400 + 160
    end

    it "規則可以多個" do
      p3 = create(:product, price: 50)
      p4 = create(:product, price: 30)

      cart.set_additional(p2.id, p1.id, 80)
      cart.set_additional(p3.id, p4.id, 20)
      cart.add_item(p2.id) # 200
      cart.add_item(p1.id) # 80
      cart.add_item(p3.id) # 50
      cart.add_item(p4.id) # 20
      expect(cart.get_total.origin).to be 350

      cart.update_quantity(p1.id, 2) # 100
      cart.update_quantity(p4.id, 2) # 30
      expect(cart.get_total.origin).to be 480

      cart.update_quantity(p2.id, 2) # p1有兩件可以有加購價
      cart.update_quantity(p3.id, 2) # p4有兩件可以有加購價
      expect(cart.get_total.origin).to be 700  # 400 + 160 + 100 + 40
    end

    it "A可以有多個B" do
      p3 = create(:product, price: 50)
      cart.set_additional(p2.id, p1.id, 80)
      cart.set_additional(p2.id, p3.id, 40)

      cart.add_item(p2.id) # 200
      cart.add_item(p1.id) # 80
      cart.add_item(p3.id) # 40
      expect(cart.get_total.origin).to be 320

      # 買第二個時沒有加購價惹 QQ
      cart.add_item(p1.id) # 100
      cart.add_item(p3.id) # 50
      expect(cart.get_total.origin).to be 470
    end

    it "移除A商品B商品會被取消加購價(變回原價)" do
      cart.set_additional(p1.id, p2.id, 80)
      cart.add_item(p1.id)
      cart.add_item(p2.id)
      cart.remove_item(p1.id)

      expect(cart.get_total.origin).to be 200
    end

    it "移除B商品，扣除B商品的加購價(不會扣原價)" do
      cart.set_additional(p1.id, p2.id, 80)
      cart.add_item(p2.id)
      cart.add_item(p1.id)
      cart.remove_item(p2.id)
      expect(cart.get_total.origin).to be 100
    end

    it "某A有多個B時，A被移除後所有B都會變回原價" do
      p3 = create(:product, price: 50)
      p4 = create(:product, price: 30)
      cart.set_additional(p2.id, p1.id, 80)
      cart.set_additional(p2.id, p3.id, 40)
      cart.set_additional(p2.id, p4.id, 20)

      cart.add_item(p2.id) # 200
      cart.add_item(p1.id) # 80
      cart.add_item(p3.id) # 40
      cart.add_item(p4.id) # 20
      expect(cart.get_total.origin).to be 340

      cart.remove_item(p2.id)
      expect(cart.get_total.origin).to be 180 # 100 + 50 + 30
    end
  end
end
