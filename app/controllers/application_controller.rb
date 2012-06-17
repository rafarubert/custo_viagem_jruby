class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :defaults
  protected

  def defaults
    @airports = Airport.to_a.sort { |a, b| a.last <=> b.last }
  end
end
