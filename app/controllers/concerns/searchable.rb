module Searchable
  extend ::ActiveSupport::Concern

  # 有帶入任何查詢條件
  def with_any_condition?
    !condition_params_mapping.keys.all? {|s| params[s].blank?}
  end


  # format to [ { colunm: 'column_name', operator: '=', value: 'param_value' }, { .... } ]
  def conditions
    condition_params_mapping.each_with_object([]) do |(param_key, condition), result|
      unless search_params[param_key].blank?
        value = if condition[:operator] == 'LIKE'
                  "%#{search_params[param_key]}%" # 模糊比對
                else
                  search_params[param_key]
                end

        result << { value:  value }.merge(condition)
      end
    end
  end

  def search_params
    raise NotImplementedError
  end

  def condition_params_mapping
    raise NotImplementedError
  end
end
