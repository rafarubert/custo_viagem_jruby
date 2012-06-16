require 'open-uri'
require 'json'

class Passage
  def self.find(origin = String.new, destination = String.new, initial_date = String.new, final_date = String.new)
    build = []
    scales = {'noScale' => 0, 'oneScale' => 1, 'twoScale' => 2}
    name = String.new
    price = String.new

    url = "http://www.decolar.com/shop/flights/data/search/roundtrip/#{origin}/#{destination}/#{initial_date}/#{final_date}/1/0/0/FARE/ASCENDING/NA/NA/NA/NA/NA"

    buffer = open(url, "UserAgent" => "Ruby-Wget").read

    result = JSON.parse(buffer)
    result['result']['matrix'].each do |airline|
      ['noScale','oneScale','twoPlusScales'].each do |scale|
        if airline[scale]
          
          airline[scale]['prices'].each do |p|
            p.each do |f|
              build << {
                :name => airline['airline']['description'],
                :scales => scales[scale],
                :price => (f[1]['amount'] if f and f[1] and f[1]['amount']),
                :mask => (f[1]['mask'] if f and f[1] and f[1]['mask'])
              }
            end
          end
        end
      end

    end

    build
  end
  
end