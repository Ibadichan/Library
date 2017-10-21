class CreateUsersBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :users_books do |t|
      t.references :book, index: true
      t.references :user, index: true
    end
  end
end
