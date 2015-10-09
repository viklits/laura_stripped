class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :license_plate_number, :string
    add_column :users, :license_plate_state, :string
    add_column :users, :driver_license, :string
    add_column :users, :driver_license_state, :string
    add_column :users, :state, :string
    add_column :users, :address, :string
  end
end
