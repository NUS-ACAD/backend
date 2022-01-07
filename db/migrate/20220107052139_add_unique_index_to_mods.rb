class AddUniqueIndexToMods < ActiveRecord::Migration[7.0]
  def change
    add_index :mods, [:semester_id, :module_code], unique: true
  end
end
