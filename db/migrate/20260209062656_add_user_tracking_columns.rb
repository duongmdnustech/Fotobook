class AddUserTrackingColumns < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :last_login_at, :datetime, :default => Time.current
    add_column :users, :active, :boolean, :default => true
  end
end
