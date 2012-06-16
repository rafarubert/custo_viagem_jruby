class TripsController < ApplicationController
  
  before_filter :load_trip
  
  def index
    @passages = Passage.find(@trip.origin, @trip.destination, @trip.initial_date, @trip.final_date)
  end
  
  private
  
  def load_trip
    @trip = Trip.new(params[:trip] || {})
  end
  
end