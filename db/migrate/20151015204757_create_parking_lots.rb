class CreateParkingLots < ActiveRecord::Migration
  def change
    create_table :parking_lots do |t|
      t.references :parking, index: true, foreign_key: true
      t.boolean :availaible
      t.integer :slot_id
      t.timestamps null: false
    end
  end
end
