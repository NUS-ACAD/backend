class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.integer :group_id
      t.integer :user_id
      t.boolean :is_owner

      t.timestamps
    end
  end
end
