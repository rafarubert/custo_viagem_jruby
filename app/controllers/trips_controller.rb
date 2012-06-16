class TripsController < ApplicationController
  
  before_filter :load_trip
  
  def index
<<<<<<< HEAD
    @trip.save
    @hotels = Hotel.find_by_city(Airport.value_for(@trip.destination))
    begin
      @passages = Passage.find(@trip.origin, @trip.destination, @trip.initial_date, @trip.final_date)
      
    rescue Exception => e
      puts e.inspect
      render :error
    end
  end
  
  def show
    @top = Trip.top18
  end
  
=======
    @passages = Passage.find(@trip.origin, @trip.destination, @trip.initial_date, @trip.final_date)
  end
  
>>>>>>> Busca de trip
  private
  
  def load_trip
    @trip = Trip.new(params[:trip] || {})
  end
  
end