class Spec < ApplicationRecord

  validates :name, presence: true
  validates :quantity,
    presence: true,
    numericality: { only_integer: true }

  validates_each :name do |record, attr, name|
    names = record.product.specs.map(&:name)
    names.delete_if { |name| name.blank? }

    record.errors.add attr, :taken if names.count(name) > 1
  end
  belongs_to :product

end
