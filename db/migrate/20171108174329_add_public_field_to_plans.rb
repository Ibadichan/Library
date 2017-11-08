class AddPublicFieldToPlans < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :public, :boolean, default: false
  end
end
