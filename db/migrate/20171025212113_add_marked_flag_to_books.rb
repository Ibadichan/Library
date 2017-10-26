class AddMarkedFlagToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :marked, :boolean, default: false
  end
end
