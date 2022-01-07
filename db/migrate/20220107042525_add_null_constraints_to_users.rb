class AddNullConstraintsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:users, :name, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :primary_degree, true)
    change_column_null(:users, :second_degree, true)
    change_column_null(:users, :second_major, true)
    change_column_null(:users, :second_minor, true)
    change_column_null(:users, :matriculation_year, true)
  end
end
