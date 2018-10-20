class User < ApplicationRecord
  scope :owners, -> { where(type:"Owner") }
  scope :fixers, -> { where(type:"Fixer") }
end
