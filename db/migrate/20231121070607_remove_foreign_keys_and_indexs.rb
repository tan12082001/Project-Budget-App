class RemoveForeignKeysAndIndexs < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :categories, column: :expenditures_id
    remove_index :categories, column: :expenditures_id

    remove_foreign_key :expenditures, column: :categories_id
    remove_index :expenditures, column: :categories_id
  end
end
