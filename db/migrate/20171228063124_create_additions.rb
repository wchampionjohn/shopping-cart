class CreateAdditions < ActiveRecord::Migration[5.1]
  def change
    create_table :additions do |t|
      t.integer :purchase_product_id
      t.boolean :is_limited
      t.date :limited_start_date
      t.date :limited_end_date
      t.integer :cart_function_id

      t.timestamps
    end
  end
end
