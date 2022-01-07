class AddForeignKeysToInvites < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :invites, :users, column: :invitee_id
    add_foreign_key :invites, :groups, column: :group_id
  end
end
