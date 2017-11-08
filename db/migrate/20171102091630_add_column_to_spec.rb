class AddColumnToSpec < ActiveRecord::Migration[5.1]
  def change
    add_column :specs, :quantity , :integer
  end
end
