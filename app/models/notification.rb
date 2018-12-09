class Notification < ApplicationRecord
    belongs_to :user
    belongs_to :message
    belongs_to :bid, required: false
end
