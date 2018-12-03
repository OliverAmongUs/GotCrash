class Report < ApplicationRecord
  belongs_to :owner
  has_many :bids
  has_many :report_join_autos
  has_many :auto_parts, through: :report_join_autos
  mount_uploader :picture_url, AvatarUploader
end
