class CreateParkings < ActiveRecord::Migration
  def change
    create_table :parkings do |t|
      t.string :name
      t.decimal :lat ,{:precision=>10, :scale=>6}
      t.decimal :lng ,{:precision=>10, :scale=>6}
      t.integer :total_capacity
      t.integer :filled
      t.integer :cost
      t.timestamps null: false
    end
  end
end
