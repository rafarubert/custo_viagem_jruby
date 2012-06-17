#encoding: #utf-8
class Trip < ActiveRecord::Base
  include EnumerateIt

  attr_accessible :destination, :final_date, :initial_date, :origin, :total, :trip_item_attributes

  has_many :trip_items

  accepts_nested_attributes_for :trip_items

  scope :top18, select('count(*) as total, trips.origin, trips.destination').group('trips.origin, trips.destination').order('total desc')

  validates :origin, :destination, :initial_date, :final_date, :presence => true

  validates_datetime :initial_date, :after => Date.current
  validates_datetime :final_date, :after => :initial_date

  validates_each :origin, :destination do |record, attr, value|
    if record[:origin] == record[:destination]
      record.errors.add(attr, 'Origem e Destino não podem ser os mesmos')
    end
  end
end