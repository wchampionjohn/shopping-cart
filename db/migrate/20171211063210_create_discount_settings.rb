class CreateDiscountSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :discount_settings do |t|
      t.integer :condition
      t.integer :offer
      t.integer :percent_off
      t.integer :discount_type
      t.boolean :is_limited
      t.date :limited_start_date
      t.date :limited_end_date
      t.integer :cart_function_id

      t.timestamps
    end
  end
end
