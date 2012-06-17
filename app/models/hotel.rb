require 'open-uri'
require 'nokogiri'

class Hotel
  def find_by_city(city)
    build = Hash.new

    original_price = String.new
    actual_price = String.new

    name = String.new
    price = String.new
    
    response = open("http://www.hotelurbano.com.br/busca?q=#{city}")
    if response.status == 200:
      document = Nokogiri::HTML(response)

      document.css('.dados-oferta-mini').each do |doc|
        name = doc.children.css('.dados-textuais-mini > h2 > span').text

        original_price = doc.children.css('.valor-oferta-mini > p.preco-original-mini').text
        actual_price =  doc.children.css('.valor-oferta-mini > p.preco-atual-mini').text

        price =  original_price.blank? ? actual_price : original_price
        price.gsub!(/[a-zA-z]|\ |\$/, '')
        build[name] = ActionController::Base.helpers.number_to_currency(price, :unit => 
          "R$", :separator => ",",:delimiter => ".")
      end
      
      return build
    end
    return nil
  end
end
