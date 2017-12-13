class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :null_session
  helper_method :function_item?
  helper_method :product_item?

  # return Format [ { id => [message, message] }, id => [message, message] } ]
  def formated_of(error_records)
    error_records.inject({}) do |result, record|
      result.merge({ record.id => record.errors.full_messages })
    end
  end

  def function_item? path
    [
      'admin/discount_settings',
      'admin/functions',
      'admin/costs'
    ].include?(params[:controller])
  end

  def product_item? path
    path_params = Rails.application.routes.recognize_path path
    path_params[:controller] == params[:controller]
  end

  def after_sign_out_path_for(resource_or_scope)
    return new_admin_session_path if resource_or_scope == :admin
    super
  end

  def after_sign_in_path_for(resource_or_scope)
    return admin_authenticated_root_path
    super
  end

  def layout_by_resource

    if request.xhr?
      false
    else
      devise_controller? ? 'devise' : 'application'
    end

  end

end
