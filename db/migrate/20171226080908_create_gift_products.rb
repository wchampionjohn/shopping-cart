class CreateGiftProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :gift_products do |t|
      t.integer :gift_id
      t.integer :product_id

      t.timestamps
    end
  end
end
