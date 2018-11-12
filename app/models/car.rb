class Car < ApplicationRecord
  belongs_to :owner
  mount_uploader :picture_url, AvatarUploader
end
