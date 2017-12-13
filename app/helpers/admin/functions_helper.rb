module Admin::FunctionsHelper
  def detail_edit_path function
    mapping = {
      'costs' => admin_costs_path,
      'discount' => admin_discount_settings_path
    }

    mapping[function.name]
  end
end
