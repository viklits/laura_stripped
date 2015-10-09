class AddNewFieldsToAchPayment < ActiveRecord::Migration
  def change
    add_column :ach_payments, :middle_name, :string
    add_column :ach_payments, :first_name, :string
    add_column :ach_payments, :last_name, :string
    add_column :ach_payments, :account_nr, :string
    rename_column :ach_payments, :routing, :routing_nr
  end
end
