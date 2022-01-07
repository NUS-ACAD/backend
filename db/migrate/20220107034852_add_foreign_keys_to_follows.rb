class AddForeignKeysToFollows < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :follows, :users, column: :follower_id
    add_foreign_key :follows, :users, column: :followed_id

  end
end
