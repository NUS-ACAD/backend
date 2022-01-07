class AddForeignKeyToSemesters < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :semesters, :users, column: :plan_id
  end
end
