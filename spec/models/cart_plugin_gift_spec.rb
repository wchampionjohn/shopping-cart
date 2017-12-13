require 'rails_helper'

RSpec.describe CartPluginGift, type: :model do
  let(:cart) do
    cart = Cart.new
    cart.register_plugin('gift')

    cart
  end

  let(:p1) { create(:product) }
  let(:p2) { create(:product) }

  describe "買A商品，送B商品" do
    it "A商品加入購物車後，會記錄贈品" do
      cart.set_gift(p1.id, p2.id)
      cart.add_item(p1.id)

      expect(cart.get_gift).to eq ( { p1.id => { id: p2.id, amount: 1 } } )
    end

    it "同時設定多個贈品" do
      p3 = create(:product)
      p4 = create(:product)

      cart.set_gift(p1.id, p2.id)
      cart.set_gift(p3.id, p4.id)

      cart.add_item(p1.id)
      cart.add_item(p3.id)

      result = {
        p1.id => { id: p2.id, amount: 1},
        p3.id => { id: p4.id, amount: 1},
      }

      expect(cart.get_gift).to eq result
    end

    it "更新數量時會相對減少贈品數量" do
      cart.set_gift(p1.id, p2.id)
      5.times { cart.add_item p1.id }
      expect(cart.get_gift).to eq ( { p1.id => { id: p2.id, amount: 5 } } )

      cart.update_quantity(p1.id, 3)
      expect(cart.get_gift).to eq ( { p1.id => { id: p2.id, amount: 3 } } )
    end

    it "移除商品會移除相對的贈品" do
      p3 = create(:product)
      p4 = create(:product)

      cart.set_gift(p1.id, p2.id)
      cart.set_gift(p3.id, p4.id)

      cart.add_item(p1.id)
      cart.add_item(p3.id)

      result = {
        p1.id => { id: p2.id, amount: 1},
        p3.id => { id: p4.id, amount: 1},
      }
      expect(cart.get_gift).to eq result

      cart.remove_item(p3.id)
      expect(cart.get_gift).to eq ( { p1.id => { id: p2.id, amount: 1 } } )
    end
  end
end
