class Category < ApplicationRecord
has_many :post_categories
has_many :posts, through: :poskt_categories
end
