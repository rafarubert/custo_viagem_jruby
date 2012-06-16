class Trip < ActiveRecord::Base
  include EnumerateIt
  attr_accessible :destination, :final_date, :initial_date, :origin
  has_many :trip_items

  validates :origin, :destination, :initial_date, :final_date, :presence => true

end