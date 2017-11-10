class Product < ApplicationRecord

  paginates_per 10

  mount_uploader :image_path, ::ProductImageUploader

  validates :title, :status, presence: true

  validates :price, :calculate,
    presence: true,
    numericality: { only_integer: true },
    length: { maximum: 8 }

  has_many :specs, validate: true

  accepts_nested_attributes_for :specs, allow_destroy: true

  enum status: [:all_new, :like_new, :used]

  scope :filter_with, -> (keyword) do
    where("title LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  after_save :update_calculate

  def extension_white_list
    %w(jpg jpeg gif png)
  end

private
  def update_calculate
    if specs.present?
      calculate = specs.reduce(0) { |result, spec| result += spec.quantity }
      update_column(:calculate, calculate)
    end
  end

end
