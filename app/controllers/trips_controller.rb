class TripsController < ApplicationController

  before_filter :load_trip

  def new
    @top = Trip.top18
  end

  def create
    @trip.save
    begin
      @passages = Passage.find(@trip.origin, @trip.destination, @trip.initial_date, @trip.final_date)
      @hotels   = Hotel.find_by_city(Airport.value_for(@trip.destination))
    rescue Exception => e
      render :error
    end
  end

  private

  def load_trip
    @trip = Trip.new(params[:trip] || {})
  end
end