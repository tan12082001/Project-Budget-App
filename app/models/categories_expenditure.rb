class CategoriesExpenditure < ApplicationRecord
  belongs_to :category
  belongs_to :expenditure
end
