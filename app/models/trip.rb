class Trip < ActiveRecord::Base
  attr_accessible :destination, :final_date, :initial_date, :origin
  has_many :trip_items
end