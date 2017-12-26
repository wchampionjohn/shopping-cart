module Admin::FunctionsHelper
  def detail_edit_path function
    mapping = {
      'costs' => admin_costs_path,
      'discount' => admin_discount_settings_path
    }

    if mapping.include? function.name
      mapping[function.name]
    else
      edit_admin_function_path function
    end
  end
end
