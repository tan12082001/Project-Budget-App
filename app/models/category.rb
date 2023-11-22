class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenditures
  #has_many :categories_expenditures, dependent: :destroy
  #has_many :expenditures, through: :categories_expenditures

  def expenditures_sum
    expenditures.sum(:amount)
  end
end
