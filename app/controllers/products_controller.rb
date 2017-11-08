class ProductsController < ResourcesController

  include Paginationable

  helper_method :params

  def create
    @current_object = collection_scope.create(object_params)
    if @current_object.valid?
      flash[:success] = '新增成功'
      redirect_to url_after_create
    else
      if @current_object.errors.keys.any? { |attr| /^specs/ =~ attr }
        @specs_mseeages = current_object.specs.each.with_index.inject({}) do |result, (spec, index)|
          result[index] = spec.errors.to_h unless spec.valid?
          result
        end
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
      # 錯誤訊息有specs
      if current_object.errors.keys.any? { |attr| /^specs/ =~ attr }
        @specs_mseeages = current_object.specs.each.with_index.inject({}) do |result, (spec, index)|
          result[index] = spec.errors.to_h unless spec.valid?
          result
        end
        flash[:alert] = '更新失敗'
        render action: :edit
      end
    end
  end

  def index
    respond_to do |f|
      f.html do
        render :index
      end
      f.json do
       render json: collection_scope,
              each_serializer: ProductSerializer,
              status: :ok,
              meta: {
                pagination: pagination_dict(collection_scope),
                statuses: Product.human_attribute_enum('status')
              }
      end
    end
  end

  def batch_update
    product_ids = products_params.pluck(:id)
    update_params = products_params.map do |product|
      product.permit(:id, :title, :description, :price, :calculate, :status)
    end

    products = Product.update(product_ids, update_params)
    errors_products = products.select { |product| product.errors.present? }

    if errors_products.present?
      render json: formated_of(errors_products), status: :unprocessable_entity
    else
      render json: {}, status: :ok
    end
  end

  def batch_delete
    ids = params['ids'].map(&:to_i)
    Product.where(id: ids).delete_all
    render json: {}, status: :ok
  end

  def collection_scope
    if params['keyword'].present?
      Product.filter_with(params['keyword']).order(:id).page(params['page'].try(:to_i))
    else
      Product.order(:id).page(params['page'].try(:to_i))
    end
  end

  private
  def products_params
    params.require(:products)
  end

  def object_params
    params.require(:product).permit(:title, :price, :status, :calculate, :description, {specs_attributes: [:id, :name, :quantity, :_destroy]} )
  end

  def url_after_update
    edit_product_path
  end
end
