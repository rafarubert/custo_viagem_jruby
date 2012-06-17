require 'open-uri'
require 'nokogiri'
require 'uri'

class Taxi
  
  def self.find_by_meters(meters)
    response = open(URI.escape("http://www.hotelurbano.com.br/busca?q=#{city}"))
    return if response.status[0] != '200'
    return response.body
  end
end
