class Fixer < User
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :type, presence: true
end
