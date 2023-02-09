class AddThreeColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :travel_period, :string
    add_column :users, :number_of_countries, :string
    add_column :users, :favorite_country, :string    
  end
end
