class AddDevicesToUser < ActiveRecord::Migration
  def change
    add_column :users, :devices, :jsonb
  end
end
