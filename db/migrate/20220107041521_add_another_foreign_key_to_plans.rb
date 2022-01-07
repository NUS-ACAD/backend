class AddAnotherForeignKeyToPlans < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :plans, :plans, column: :forked_plan_source_id
  end
end
