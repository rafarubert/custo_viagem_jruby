require 'open-uri'
require 'nokogiri'
require 'uri'

class Hotel

  def self.find_by_city(city)
    build = []
<<<<<<< HEAD
    document = Nokogiri::HTML(open("http://www.hotelurbano.com.br/busca?q=#{city}"))
=======
    response = open(URI.escape("http://www.hotelurbano.com.br/busca?q=#{city}"))
    return if response.status[0] != '200'

    document = Nokogiri::HTML(response)
>>>>>>> 4556dd1507245350f15afaea6f5d28ef3ffceb6d
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
  
end
