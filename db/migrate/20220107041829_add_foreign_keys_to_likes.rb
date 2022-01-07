class AddForeignKeysToLikes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :likes, :users, column: :user_id
    add_foreign_key :likes, :plans, column: :plan_id
  end
end
