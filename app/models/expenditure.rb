class Expenditure < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :categories
  # has_many :categories_expenditures, dependent: :destroy
  # has_many :categories, through: :categories_expenditures
  # accepts_nested_attributes_for :categories_expenditures, allow_destroy: true
end
