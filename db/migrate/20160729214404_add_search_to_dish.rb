class AddSearchToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :search, :string 
  end
end
