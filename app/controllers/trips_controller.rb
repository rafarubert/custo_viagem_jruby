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

      if @trip.id
        @passages.each do |passage|
          @trip.trip_items << TripItem.new(
            :key => passage[:name],
            :value => passage[:diarias],
            :options => "#{passage[:mask]} #{passage[:price]}",
            :service => 'passage',
            :trip_id => @trip.id
          )
        end

        @hotels.each do |hotel|
          TripItem.create(
            :key => hotel[:name],
            :value => hotel[:scales],
            :options => hotel[:scales],
            :service => 'hotel',
            :trip_id => @trip.id
          )
        end
      end

    rescue Exception => e
      render :error
    end
  end

  private

  def load_trip
    @trip = Trip.new(params[:trip] || {})
  end
end