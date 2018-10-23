class Review < ApplicationRecord
  belongs_to :bid
  belongs_to :fixer
end
