class AddTitleToMods < ActiveRecord::Migration[7.0]
  def change
    add_column :mods, :module_title, :string
  end
end
