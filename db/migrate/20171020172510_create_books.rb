class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :google_book_id

      t.timestamps
    end
  end
end
