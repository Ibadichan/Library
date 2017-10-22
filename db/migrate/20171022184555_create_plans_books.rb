class CreatePlansBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :plans_books do |t|
      t.references :plan, index: true
      t.references :book, index: true
    end
  end
end
