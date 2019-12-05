class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    # create restuarants table
    # create table 
    create_table :restaurants do |t|
      t.string :name
      t.string :cuisine
    end

    
    
  end
end
