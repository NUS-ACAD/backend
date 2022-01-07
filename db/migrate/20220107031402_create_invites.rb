class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.integer :invitee_id
      t.integer :group_id
      t.string :status

      t.timestamps
    end
  end
end
