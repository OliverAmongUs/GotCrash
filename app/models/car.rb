class Car < ApplicationRecord
  belongs_to :owner
  mount_uploader :picture_url, AvatarUploader
  # before_save { vin.downcase! }
  # VALID_VIN_REGEX = /([A-Z]|[0-9])+/
  # validates :vin,  presence: true, length: { maximum: 17, minimum: 17 },
  #                  uniqueness: { case_sensitive: false },
  #                  format: { with: VALID_VIN_REGEX }
  # validates :make,  presence: true
  # validates :model,  presence: true
  # validates :year,  presence: true
  # validates :color,  presence: true
  # validates :licence,  presence: true

end
