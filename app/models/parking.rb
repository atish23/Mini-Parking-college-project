class Parking < ActiveRecord::Base
  has_many :transactions
  has_many :parking_lots
end
