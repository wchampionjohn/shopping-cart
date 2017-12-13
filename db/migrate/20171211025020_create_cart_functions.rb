class CreateCartFunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_functions do |t|
      t.string :title
      t.string :name
      t.boolean :is_open
      t.text :memo

      t.timestamps
    end
  end
end
