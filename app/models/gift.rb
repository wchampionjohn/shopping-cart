# 買A送B設定
class Gift < ApplicationRecord

  include Limitable

  validates :products, :purchase_product_id,
    presence: true
  validates :purchase_product_id, uniqueness: true
  #validate :check_gift_and_purchase

  has_many :gift_products
  has_many :products, through: :gift_products, source: :product
  belongs_to :purchase_product, class_name: "Product", foreign_key: "purchase_product_id"

  accepts_nested_attributes_for :products

  def check_gift_and_purchase
    if gift_product_id == purchase_product_id
      errors.add(:purchase_product_id, "贈送商品與購買商品不能相同")
    end
  end

end
