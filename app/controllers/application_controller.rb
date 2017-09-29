class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  # return Format [ { id => [message, message] }, id => [message, message] } ]
  def formated_of(error_records)
    error_records.inject({}) do |result, record|
      result.merge({ record.id => record.errors.full_messages })
    end
  end
end
