class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :avatar, :string
    add_column :users, :blocked, :boolean, default: false
  end
end
