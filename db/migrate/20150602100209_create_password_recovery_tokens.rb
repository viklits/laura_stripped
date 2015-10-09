class CreatePasswordRecoveryTokens < ActiveRecord::Migration
  def change
    create_table :password_recovery_tokens do |t|
      t.string :token
      t.string :email
      t.references :user
      t.timestamps null: false
    end
  end
end
