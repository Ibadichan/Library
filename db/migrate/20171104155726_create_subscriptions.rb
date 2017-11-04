class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :plans_book, index: true
      t.timestamps
    end
  end
end
