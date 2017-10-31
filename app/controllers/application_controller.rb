class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_item?

  # return Format [ { id => [message, message] }, id => [message, message] } ]
  def formated_of(error_records)
    error_records.inject({}) do |result, record|
      result.merge({ record.id => record.errors.full_messages })
    end
  end

  def current_item? path
    path_params = Rails.application.routes.recognize_path path
    path_params[:controller] == controller_name
  end
end
