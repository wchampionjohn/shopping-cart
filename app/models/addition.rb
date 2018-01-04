class Addition < ApplicationRecord
  include Limitable

  validates :addition_products, :purchase_product_id,
    presence: true
  validates :purchase_product_id, uniqueness: true

  has_many :addition_products
  has_many :products, through: :addition_products, source: :product

  belongs_to :purchase_product, class_name: "Product", foreign_key: "purchase_product_id"
  belongs_to :cart_function

  accepts_nested_attributes_for :addition_products, allow_destroy: true

  scope :for_search, -> do
    select("additions.*, products.title").
      joins("LEFT JOIN products ON products.id = additions.purchase_product_id")
  end

  after_initialize :default_values

  def default_values
    self.cart_function = CartFunction.find_by_name('additional')
  end
end
