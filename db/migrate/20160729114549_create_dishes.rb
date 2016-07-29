class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.decimal :price
      t.integer :restaurant_id
      t.text :ingredients
    end
  end
end
