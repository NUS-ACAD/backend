class RenameSemesterNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column :semesters, :semester, :semester_no
  end
end
