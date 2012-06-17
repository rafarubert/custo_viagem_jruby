class TripItem < ActiveRecord::Base
  belongs_to :trip
  attr_accessible :key, :value, :options, :service, :trip_id
end