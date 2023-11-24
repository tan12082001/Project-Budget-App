class Expenditure < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :categories

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { money: true, greater_than_or_equal_to: 0 }
end
