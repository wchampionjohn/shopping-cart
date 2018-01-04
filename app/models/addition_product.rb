class AdditionProduct < ApplicationRecord
  belongs_to :addition
  belongs_to :product

  validates :product, uniqueness: { scope: :addition }
  validates :price,
    presence: true,
    numericality: { only_integer: true },
    length: { maximum: 8 }
  validates :product_id, uniqueness: true
end
