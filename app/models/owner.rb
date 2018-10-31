class Owner < User
  has_many :reports
  has_many :cars
end
