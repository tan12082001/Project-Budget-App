class AddOnDeleteCascadeToForeignKeys < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :categories, column: "expenditures_id"
    remove_foreign_key :categories, :users
    remove_foreign_key :expenditures, column: "categories_id"
    remove_foreign_key :expenditures, column: "author_id"

    add_foreign_key :categories, :expenditures, column: "expenditures_id", on_delete: :cascade
    add_foreign_key :categories, :users, on_delete: :cascade
    add_foreign_key :expenditures, :categories, column: "categories_id", on_delete: :cascade
    add_foreign_key :expenditures, :users, column: "author_id", on_delete: :cascade
  end
end
