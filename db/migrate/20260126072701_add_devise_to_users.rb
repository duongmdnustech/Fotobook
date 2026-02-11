# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    add_column :users, :remember_created_at, :datetime

    # add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  # def self.down
  #   # By default, we don't want to make any assumption about how to roll back a migration when your
  #   # model already existed. Please edit below which fields you would like to remove in this migration.
  #   raise ActiveRecord::IrreversibleMigration
  # end
end
