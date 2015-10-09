class CreateAchPayments < ActiveRecord::Migration
  def change
    create_table :ach_payments do |t|
      t.string :routing
      t.references :user
      t.timestamps null: false
    end
  end
end
