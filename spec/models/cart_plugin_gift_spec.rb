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

      expect(cart.get_gift).to eq ( { p1.id.to_s => [p2.id] } )
    end

    it "一個A商品可以對多個B商品" do
      p3 = create(:product)
      p4 = create(:product)

      cart.set_gift(p1.id, p2.id)
      cart.set_gift(p1.id, p3.id)

      cart.add_item(p1.id)

      expect(cart.get_gift).to eq p1.id.to_s => [p2.id, p3.id]
    end

    it "可以有多個設定" do
      p3 = create(:product)
      p4 = create(:product)

      cart.set_gift(p1.id, p2.id)
      cart.set_gift(p3.id, p4.id)
      cart.add_item p1.id
      expect(cart.get_gift).to eq ( { p1.id.to_s => [p2.id] } )

      cart.add_item p3.id
      expect(cart.get_gift).to eq ( { p1.id.to_s =>  [p2.id], p3.id.to_s =>  [p4.id] } )
    end

    it "移除商品會移除相對的贈品" do
      p3 = create(:product)
      p4 = create(:product)

      cart.set_gift(p1.id, p2.id)
      cart.set_gift(p3.id, p4.id)

      cart.add_item(p1.id)
      cart.add_item(p3.id)

      result = {
        p1.id.to_s => [p2.id],
        p3.id.to_s => [p4.id]
      }
      expect(cart.get_gift).to eq result

      cart.remove_item(p3.id)
      result.delete p3.id.to_s
      expect(cart.get_gift).to eq result
    end
  end
end
