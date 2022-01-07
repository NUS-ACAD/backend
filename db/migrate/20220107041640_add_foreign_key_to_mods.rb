class AddForeignKeyToMods < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :mods, :semesters, column: :semester_id
  end
end
