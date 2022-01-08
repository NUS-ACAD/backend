class AddColumnsToFeed < ActiveRecord::Migration[7.0]
  def change
    add_column :feeds, :plan_name, :string
    add_column :feeds, :group_name, :string
    add_column :feeds, :second_plan_name, :string
    add_column :feeds, :user_name, :string
  end
end
