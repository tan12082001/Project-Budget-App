class AddExpendituresRefToCategories < ActiveRecord::Migration[7.1]
  def change
    add_reference :categories, :expenditures, null: false, foreign_key: true
  end
end
