class AddForeignKeysToMembers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :members, :groups, column: :group_id
    add_foreign_key :members, :users, column: :user_id
  end
end
