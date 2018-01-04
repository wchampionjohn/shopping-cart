class Admin::AdditionsController < ResourcesController
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include Searchable

  helper_method :available_products

  def create
    @current_object = collection_scope.create(object_params)
    if @current_object.valid?
      flash[:success] = '新增成功'
      redirect_to url_after_create
    else
      if current_object.errors.keys.any? { |attr| /^addition_product/ =~ attr }
        @addition_product_mseeages = collection_addition_products_error_message
      end
      flash[:alert] = '新增失敗'
      render :new
    end
  end

  def update
    if current_object.update(object_params)
      flash[:success] = '更新成功'
      redirect_to url_after_update
    else
      if current_object.errors.keys.any? { |attr| /^addition_product/ =~ attr }
        @addition_product_mseeages = collection_addition_products_error_message
      end

      flash[:alert] = '更新失敗'
      render action: :edit
    end
  end

  def collection_scope
    if with_any_condition?
      Addition.for_search.filter_search_conditions(conditions)
    else
      Addition.all
    end
  end

  def object_params
    params.require(:addition)
          .permit(:purchase_product_id, :is_limited, :limited_start_date,
                  :limited_end_date, {addition_products_attributes: [:id, :product_id, :price, :_destroy]})
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
      title: {
        column: 'products.title',
        operator: 'LIKE'
      }
    }
  end

  def collection_addition_products_error_message
    current_object.addition_products.each.with_index.inject({}) do |result, (product, index)|
      result[index] = product.errors.to_h unless product.valid?
      result
    end

  end

  def url_after_update
    edit_admin_addition_path
  end

  def url_after_create
    edit_admin_addition_path(Addition.last)
  end

end
