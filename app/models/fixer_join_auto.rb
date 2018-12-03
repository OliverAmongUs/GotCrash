class FixerJoinAuto < ApplicationRecord
  belongs_to :fixer
  belongs_to :auto_part
end
