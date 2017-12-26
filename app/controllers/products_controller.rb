class ProductsController < ResourcesController

  def collection_scope
    Product.available.order(:created_at).page(params[:page]).per(8)
  end

  alias current_collection collection_scope

end
