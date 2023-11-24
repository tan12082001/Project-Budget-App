class CreateExpendituresCategoriesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :expenditures_categories, id: false do |t|
      t.bigint :expenditure_id, null: false
      t.bigint :category_id, null: false
    end

    add_index :expenditures_categories, [:expenditure_id, :category_id], unique: true
  end
end
