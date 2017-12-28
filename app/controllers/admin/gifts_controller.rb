class Admin::GiftsController < ResourcesController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Searchable

  helper_method :available_products

  def collection_scope
    Gift.all
  end

  def object_params
    params.require(:gift)
          .permit(:purchase_product_id, :is_limited, :limited_start_date,
                  :limited_end_date, :product_ids => [])
  end

  def available_products
    Product.available.map do |product|
      [product.id, "#{product.title} (#{currency(product.price)})"]
    end
  end

private
  def search_params
    params.permit(:title, :page)
  end


  def condition_params_mapping
    {
      type: {
        column: 'special_type',
        operator: '='
      },
      title: {
        column: 'products.title',
        operator: 'LIKE'
      }
    }
  end

end
