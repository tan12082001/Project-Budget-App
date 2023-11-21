class User < ApplicationRecord
  has_many :categories
  has_many :expenditures, foreign_key: 'author_id'

  def total_budget
    expenditures.sum(:amount)
  end
end
