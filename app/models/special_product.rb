class SpecialProduct < ApplicationRecord

  include Limitable

  validates :special_type, presence: true
  validates :cut_offer, presence: true, numericality: { only_integer: true } , if: :cut?
  validates :specific_offer, presence: true, numericality: { only_integer: true } , if: :specific?
  validates :percent_off, presence: true, numericality: { only_integer: true }, if: :percent?
  validates_inclusion_of :percent_off, in: 1..100, if: :percent?
  validates :product_id, uniqueness: true

  belongs_to :product
  belongs_to :cart_function

  scope :for_search, -> do
    select("special_products.*, products.title").
      joins("LEFT JOIN products ON products.id = special_products.product_id")
  end

  # 特價方式
  enum special_type: [:cut, # 原價折價cut_offer元
                      :specific, # 商品指定specific_offer元
                      :percent] # 原價折percent_off%

  after_initialize :default_values

  def default_values
    self.cart_function = CartFunction.find_by_name('special')
  end

  def special_price
    origin_price = product.price

    if cut?
      origin_price - cut_offer
    elsif specific?
      specific_offer
    elsif percent?
      calculate_percent origin_price
    end
  end

  def calculate_percent origin_price
    (origin_price - origin_price * (percent_off / 100.0)).round
  end

  def human_text_of_percent
    "#{(10 - percent_off / 10.0).round(1)} 折"
  end

  def active?
    cart_function.is_open && !is_limiting?
  end

  def activity
    return nil if is_limiting?

    offer = if cut?
              cut_offer
            elsif specific?
              specific_offer
            elsif percent?
              percent_off
            end

    {
      type: special_type.to_sym,
      offer: offer
    }
  end

end
