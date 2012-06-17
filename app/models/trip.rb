class Trip < ActiveRecord::Base
  include EnumerateIt
  
  attr_accessible :destination, :final_date, :initial_date, :origin
  
  has_many :trip_items
  
  scope :top18, select('count(*) as total, trips.origin, trips.destination').group('trips.origin, trips.destination').order('total desc')

  validates :origin, :destination, :initial_date, :final_date, :presence => true
  
end