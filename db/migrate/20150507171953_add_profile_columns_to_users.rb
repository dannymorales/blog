class AddProfileColumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :address, :string
  	add_column :users, :mobile_number, :integer
  	
  end
end
