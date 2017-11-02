class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_attribute_enum(enum_name)
    Hash[self.send(enum_name.pluralize).map { |k,v| [k, self.human_attribute_name("#{enum_name}.#{k}")] } ]
  end
end
