class CreateAdditionProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :addition_products do |t|
      t.integer :addition_id
      t.integer :product_id
      t.integer :price

      t.timestamps
    end
  end
end
