class Product < ApplicationRecord
  paginates_per 10

  validates :title, :status, presence: true

  validates :price, :calculate,
    presence: true,
    numericality: { only_integer: true },
    length: { maximum: 8 }

  has_many :specs

  accepts_nested_attributes_for :specs, allow_destroy: true

  enum status: [:all_new, :like_new, :used]

  scope :filter_with, -> (keyword) do
    where("title LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

end
