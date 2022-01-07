class Fixsemesterforeignkey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :semesters, column: :plan_id
    add_foreign_key :semesters, :plans, column: :plan_id
  end
end
