class GiftProduct < ApplicationRecord
  belongs_to :gift
  belongs_to :product
end
