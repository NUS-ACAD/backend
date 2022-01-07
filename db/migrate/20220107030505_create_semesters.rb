class CreateSemesters < ActiveRecord::Migration[7.0]
  def change
    create_table :semesters do |t|
      t.integer :plan_id
      t.integer :year
      t.integer :semester

      t.timestamps
    end
  end
end
