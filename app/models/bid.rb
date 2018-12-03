class Bid < ApplicationRecord
  belongs_to :fixer
  belongs_to :report
  has_one :owner, through: :report
  has_many :messages
end
