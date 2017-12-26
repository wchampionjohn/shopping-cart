class CreateSpecialProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :special_products do |t|
      t.integer :product_id
      t.boolean :is_limited
      t.date :limited_start_date
      t.date :limited_end_date
      t.integer :special_type
      t.integer :percent_off
      t.integer :cut_offer
      t.integer :specific_offer
      t.integer :cart_function_id

      t.timestamps
    end
  end
end
