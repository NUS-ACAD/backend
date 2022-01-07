class AddForeignKeyToFeed < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :feeds, :users, column: :user_id
  end
end
