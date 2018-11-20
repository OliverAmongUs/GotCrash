class Bid < ApplicationRecord
  belongs_to :fixer
  belongs_to :report
  has_many :messages
end
