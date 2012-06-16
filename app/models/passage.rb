require 'open-uri'
require 'json'

class Passage
  def find(origin = String.new, destination = String.new, initial_date = String.new, final_date = String.new)
    build = Hash.new

    name = String.new
    price = String.new

    url = "http://www.decolar.com/shop/flights/data/search/roundtrip/#{origin}/#{destination}/#{initial_date}/#{final_date}/1/0/0/FARE/ASCENDING/NA/NA/NA/NA/NA"

    buffer = open(url, "UserAgent" => "Ruby-Wget").read

    result = JSON.parse(buffer)

    result['result']['matrix'].each do |doc|
      if doc['airline']
        name = doc['airline']['description'] if doc['airline'] and doc['airline']['description']

        if doc['noScale']
          doc['noScale']['prices'].each do |price|
            price.each do |formated|
              price = formated[1]['amount'] if formated and formated[1] and formated[1]['amount']
            end
          end
        end

      end

      if price and name
        build[name] = ActionController::Base.helpers.number_to_currency(price, :unit => "R$", :separator => ",",:delimiter => ".")
      end
    end

    build
  end
end