class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :primary_degree
      t.string :second_degree
      t.string :second_major
      t.string :first_minor
      t.string :second_minor
      t.integer :matriculation_year

      t.timestamps
    end
  end
end
