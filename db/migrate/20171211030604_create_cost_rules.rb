class CreateCostRules < ActiveRecord::Migration[5.1]
  def change
    create_table :cost_rules do |t|
      t.integer :reach
      t.integer :cost
      t.integer :cart_function_id
      t.boolean :is_open
      t.boolean :is_limited
      t.date :limited_start_date
      t.date :limited_end_date

      t.timestamps
    end
  end
end
