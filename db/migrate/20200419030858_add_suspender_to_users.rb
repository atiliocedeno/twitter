class AddSuspenderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :suspended, :boolean, default: false
  end
end
