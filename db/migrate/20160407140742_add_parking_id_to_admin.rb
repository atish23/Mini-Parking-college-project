class AddParkingIdToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :parking_id, :integer
  end
end
