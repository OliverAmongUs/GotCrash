class User < ApplicationRecord
  scope :owners, -> { where(type:"Owner") }
  scope :fixers, -> { where(type:"Fixer") }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
