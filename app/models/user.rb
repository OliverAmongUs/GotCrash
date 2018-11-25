class User < ApplicationRecord
  scope :owners, -> { where(type:"Owner") }
  scope :fixers, -> { where(type:"Fixer") }
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :address, presence: true
  validates :phone, presence: true
  validates :type, presence: true
  has_secure_password
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  mount_uploader :picture_url, AvatarUploader

end
