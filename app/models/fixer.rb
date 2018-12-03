class Fixer < User
  has_many :bids
  has_many :reviews
  has_many :fixer_join_auto_parts

end
