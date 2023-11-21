class AddExpendituresCategoriesRefToCategoriesAndExpenditures < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :expenditures_categories, :expenditures, column: :expenditure_id, on_delete: :cascade
    add_foreign_key :expenditures_categories, :categories, column: :category_id, on_delete: :cascade
  end
end
