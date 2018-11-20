class Message < ApplicationRecord
  belongs_to :user
  belongs_to :bid #, :foreign_key => :course_code, :primary_key => :code
end
