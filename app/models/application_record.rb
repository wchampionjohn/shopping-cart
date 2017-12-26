class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_enum(enum_name, key_is_number = false)
    self.send(enum_name.pluralize).map do |enum_key, enum_value|
      key = if key_is_number
              enum_value
            else
              enum_key
            end
      [key, self.human_attribute_name("#{enum_name}.#{enum_key}")]
    end.to_h
  end

  def self.filter_search_conditions(conditions)
    columns = conditions.map { |condition| " #{condition[:column]} #{condition[:operator]} (?) "}.join(" AND ")
    values =  conditions.map { |condition| condition[:value] }

    where(columns, *values)
  end

end
