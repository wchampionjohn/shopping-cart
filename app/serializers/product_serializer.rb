class ProductSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::TextHelper

  attributes :id, :title, :description, :price,
             :status, :remain, :created_at, :updated_at

  def title
    truncate(object.title, :length => 22)
  end

  def description
    truncate(object.description, :length => 25)
  end

  def created_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def updated_at
    time_ago_in_words object.updated_at
  end

end
