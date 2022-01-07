class CreateMods < ActiveRecord::Migration[7.0]
  def change
    create_table :mods do |t|
      t.integer :semester_id
      t.string :module_code
      t.text :additional_desc
      t.integer :order

      t.timestamps
    end
  end
end
