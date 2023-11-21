class RenameExpendituresCategoriesJoinTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :expenditures_categories, :categories_expenditures
  end
end
