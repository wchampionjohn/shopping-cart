class Spec < ApplicationRecord

  validates :name, presence: true

  belongs_to :product

end
