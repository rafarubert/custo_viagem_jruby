class TripsController < ApplicationController

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def create
    @trip = Trip.new(params[:trip])

    respond_to do |wants|
      if @trip.save
        wants.html { redirect_to(@trip) }
      else
        wants.html { render :action => "new" }
      end
    end
  end
end