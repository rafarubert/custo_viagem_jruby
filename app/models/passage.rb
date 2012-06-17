# encoding: utf-8
require 'open-uri'
require 'json'

class Passage

  def self.find(origin = String.new, destination = String.new, initial_date = String.new, final_date = String.new)
    build = []
    scales = {'noScale' => 'Direto', 'oneScale' => '1 Escala', 'twoPlusScales' => '2 Escalas' }

    result = JSON.parse(open("http://www.decolar.com/shop/flights/data/search/roundtrip/#{origin}/#{destination}/#{initial_date}/#{final_date}/1/0/0/FARE/ASCENDING/NA/NA/NA/NA/NA", "UserAgent" => "Ruby-Wget").read)

    if result['result']['matrix']
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
          end # end if airline each
        end # end if ariline
      end # end if matrix each
    end # end if matrix

    return [] if build.size == 0

    if result['result']['status']
      result['result']['messages'].each do |message|
        raise 'Dias de antecipação para venda atingiu o limite permitido.' if message['code'] = 'ANTICIPATION_DAYS_REACHED'
        raise 'Dias disponíveis para venda atingiu o limite permitido.' if message['code'] = 'AVAILABLE_DAYS_REACHED'
      end
    end

    build
  end

end
