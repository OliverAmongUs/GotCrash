class Report < ApplicationRecord
  belongs_to :owner
  has_many :bids
end
