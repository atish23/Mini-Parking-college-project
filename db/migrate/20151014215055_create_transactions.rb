class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.time :in
      t.time :out
      t.date :date
      t.integer :payment
      t.boolean :payment_type
      t.references :parking, index:true, foreign_key:true

      t.timestamps null: false
    end
  end
end
