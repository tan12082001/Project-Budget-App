class AddCategoriesRefToExpenditures < ActiveRecord::Migration[7.1]
  def change
    add_reference :expenditures, :categories, foreign_key: true
  end
end
