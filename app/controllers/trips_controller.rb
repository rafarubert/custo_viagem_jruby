class TripsController < ApplicationController

  before_filter :load_trip

  def new

  end

  def create
    @trip = Trip.new(params[:trip])

    respond_to do |wants|
      if @trip.save
        begin
          @passages = Passage.find(@trip.origin, @trip.destination, @trip.initial_date, @trip.final_date)
          @hotels = Hotel.find_by_city(Airport.value_for(@trip.destination))
        rescue Exception => e
          puts e.inspect
          render :error
        end
      else
        wants.html { render :action => "new" }
      end
    end
  end

  private

  def load_trip
    @trip = Trip.new(params[:trip] || {})
  end
end