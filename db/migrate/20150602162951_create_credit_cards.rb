class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.integer :cc_number
      t.string :month
      t.integer :year
      t.string :cvv
      t.string :zipcode
      t.references :user
      t.timestamps null: false
    end
  end
end
