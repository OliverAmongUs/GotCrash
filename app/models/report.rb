class Report < ApplicationRecord
  belongs_to :owner
  has_many :bids
  mount_uploader :picture_url, AvatarUploader
end
