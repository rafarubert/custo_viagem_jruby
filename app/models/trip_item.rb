class TripItem < ActiveRecord::Base
  belongs_to :trip
  attr_accessible :accepted, :key, :value
end