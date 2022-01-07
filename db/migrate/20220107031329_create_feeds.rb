class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.text :activity_type
      t.integer :plan_id
      t.integer :second_plan_id
      t.integer :group_id
      t.text :raw_data

      t.timestamps
    end
  end
end
