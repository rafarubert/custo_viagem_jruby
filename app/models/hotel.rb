require 'open-uri'
require 'nokogiri'
require 'uri'

class Hotel

  def self.find_by_city(city)
    build = []
    response = open(URI.escape("http://www.hotelurbano.com.br/busca?q=#{city}"))
    return nil if response.status == 200
    document = Nokogiri::HTML(response)
    document.css('div.dados-oferta-mini').each do |doc|
      name = doc.css('.dados-textuais-mini h2 span').text
      name = doc.css('.dados-textuais-mini h2').text if name.empty?
      diarias = doc.css('.dados-textuais-mini .diarias-hospedes-mini .aLeft .tempo_restante').text.gsub(/\s.+/,'')
      diarias = 1 if diarias.empty?
      
      build << {
        :name => name,
        :diarias => diarias,
        :price => ActionController::Base.helpers.number_to_currency(doc.css('.valor-oferta-mini > p.preco-atual-mini').text.gsub!(/[a-zA-z\$\s]/, ''), :unit => "R$", :separator => ",",:delimiter => ".")
      } if diarias.to_i > 0
  end
  
end
