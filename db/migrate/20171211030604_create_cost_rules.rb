class CreateCostRules < ActiveRecord::Migration[5.1]
  def change
    create_table :cost_rules do |t|
      t.integer :reach
      t.integer :cost
      t.integer :cart_function_id

      t.timestamps
    end
  end
end
