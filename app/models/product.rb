class Product < ApplicationRecord

  paginates_per 10

  mount_uploader :image_path, ::ProductImageUploader

  validates :title, :status, presence: true

  validates :price, :remain,
    presence: true,
    numericality: { only_integer: true },
    length: { maximum: 8 }

  has_many :specs, validate: true

  has_one :special, class_name: 'SpecialProduct'

  accepts_nested_attributes_for :specs, allow_destroy: true

  enum status: [:all_new, :like_new, :used]

  scope :filter_with, -> (keyword) do
    where("title LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
  end

  scope :available, -> { where(is_launched: 1) }

  after_save :update_calculate

  def special_hint
    if special.nil?
      ''
    else
      special.hint
    end
  end

  def real_price
    if special.try(:active?)
      special.special_price
    else
      price
    end
  end

  def full_title
    "#{title} $ #{price}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

private
  def update_calculate
    if specs.present?
      remain = specs.reduce(0) { |result, spec| result += spec.quantity }
      update_column(:remain, remain)
    end
  end

end
