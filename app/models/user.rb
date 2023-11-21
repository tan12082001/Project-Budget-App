class User < ApplicationRecord
    has_many :categories
    has_many :expenditures, foreign_key: 'author_id'
end
