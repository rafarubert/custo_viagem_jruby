class WelcomeController < ApplicationController
  def index
    @airports = Airport.to_a.sort
  end
end