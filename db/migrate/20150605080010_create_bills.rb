class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :user
      t.string :bill_type
      t.string :status
      t.string :payment_status
      t.date :payed_date
      t.float :payed_amount

      t.timestamps null: false
    end
  end
end
