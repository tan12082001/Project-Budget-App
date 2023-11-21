class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenditures

  def expenditures_sum
    expenditures.sum(:amount)
  end
end
