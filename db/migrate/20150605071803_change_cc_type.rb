class ChangeCcType < ActiveRecord::Migration
  def change
    change_column :credit_cards, :cc_number, :string
  end
end
