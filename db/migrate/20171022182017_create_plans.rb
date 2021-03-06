class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :description
      t.string :slug
      t.boolean :public, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
