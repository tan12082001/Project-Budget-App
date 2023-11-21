class RemoveColumnsFromCategoriesAndExpenditures < ActiveRecord::Migration[7.1]
  def change
    remove_column :categories, :expenditures_id
    remove_column :expenditures, :categories_id
  end
end
