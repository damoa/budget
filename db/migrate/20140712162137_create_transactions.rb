class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.date :booking_date, :null => false
      t.date :value_date, :null => false
      t.string :type, :null => false
      t.text :details
      t.string :originator, :null => false
      t.string :receiver, :null => false
      t.decimal :amount, :precision => 16, :scale => 8
      t.decimal :balance, :precision => 16, :scale => 8

      t.timestamps
    end
    
    add_index :transactions, [:value_date, :amount, :balance], :unique => true
  end
end
