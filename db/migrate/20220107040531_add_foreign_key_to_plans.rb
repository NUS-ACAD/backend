class AddForeignKeyToPlans < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :plans, :users, column: :owner_id
  end
end
