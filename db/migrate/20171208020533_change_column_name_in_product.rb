class ChangeColumnNameInProduct < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :calculate, :remain
  end
end
