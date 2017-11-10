class AddColumnsToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_path, :string, after: :status
    add_column :products, :is_launched, :boolean, after: :status
  end
end
