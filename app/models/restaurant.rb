require 'open-uri'
require 'json'

class Restaurant

  def find_by_city(city = String.new)
    url = "http://vejabrasil.abril.com.br/portal/services/search/estab/?rg=#{city}&chn=restaurantes"
    build = Hash.new

    name = String.new
    price = String.new

    buffer = open(url, "UserAgent" => "Ruby-Wget").read

    result = JSON.parse(buffer)

    result['navigators'].each do |navigator|
      puts navigator.inspect
    end
    return false
  end
end