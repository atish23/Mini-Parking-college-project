class AddCarMobileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :car_number, :string
    add_column :users, :mobile, :integer, :limit => 8
  end
end
