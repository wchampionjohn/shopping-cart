class ProductsController < ResourcesController

  include Paginationable

  helper_method :params

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
                statuses: Product.statuses
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


  def new
    @current_object = collection_scope.new
    @current_object.specs.build if current_object.specs.blank?
  end

  private
  def products_params
    params.require(:products)
  end

  def object_params
    params.require(:product).permit(:title, :price, :status, :calculate, :description, {specs_attributes: [:id, :name, :_destroy]} )
  end
end
