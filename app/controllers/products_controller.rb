class ProductsController < ResourcesController

  def collection_scope
    includes_associate = []

    includes_associate << :special if CartFunction.find_by_name(:special).is_open
    includes_associate << :gifts if CartFunction.find_by_name(:gift).is_open

    Product.includes(includes_associate)
      .available.order(:created_at)
      .page(params[:page]).per(12)
  end

  alias current_collection collection_scope

end
