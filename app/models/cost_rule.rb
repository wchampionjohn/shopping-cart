class CostRule < ApplicationRecord

  validates :reach, :cost,
    presence: true,
    numericality: { only_integer: true }

  belongs_to :cart_function

end
