class ReportJoinAuto < ApplicationRecord
  belongs_to :report
  belongs_to :auto_part
end
