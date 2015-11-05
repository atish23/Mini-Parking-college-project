class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :in
      t.datetime :out
      t.datetime :date
      t.integer :payment
      t.boolean :payment_type
      t.boolean :current_transaction
      t.references :parking,index:true,foreign_key:true
      t.references :parking_lot,index:true,foreign_key:true
      t.timestamps null: false
      t.boolean :currently_in 
    end
  end
end
