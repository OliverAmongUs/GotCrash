class AutoPart < ApplicationRecord
  has_many :report_join_autos
  has_many :fixer_join_autos
  has_many :reports, through: :report_join_autos
  has_many :fixers, through: :fixer_join_autos
end
