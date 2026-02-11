class AddAvatarToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :avatar, :string, default: nil
  end
end
