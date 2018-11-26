class Message < ApplicationRecord
  belongs_to :user
  belongs_to :bid #, :foreign_key => :course_code, :primary_key => :code
  mount_uploader :picture_url, MessageUploader
end
