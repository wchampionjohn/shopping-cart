class Admin::SpecialProductsController < ResourcesController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Searchable

  helper_method :available_products

  def collection_scope
    if with_any_condition?
      SpecialProduct.for_search.filter_search_conditions(conditions)
    else
      SpecialProduct.all
    end
  end

  def object_params
    params.require(:special_product)
          .permit(:product_id, :is_limited, :limited_start_date,
                  :limited_end_date, :percent_off, :cut_offer,
                  :specific_offer, :special_type)
  end

  def available_products
    Product.available.map do |product|
      [product.id, "#{product.title} (#{currency(product.price)})"]
    end
  end

private
  def search_params
    params.permit(:type, :title, :page)
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

  def url_after_create
    edit_admin_product_path(SpecialProduct.last)
  end
end
