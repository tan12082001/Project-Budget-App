class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenditures

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: {scope: :user, message: 'Category exists!'}
  validates :icon, presence: true
  
  def expenditures_sum
    expenditures.sum(:amount)
  end
end
