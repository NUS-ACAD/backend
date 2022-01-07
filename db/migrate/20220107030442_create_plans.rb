class CreatePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :plans do |t|
      t.integer :owner_id
      t.integer :forked_plan_source_id
      t.boolean :is_primary
      t.integer :start_year
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
