require 'open-uri'
require 'nokogiri'

class Restaurant
  #parse: fortaleza or porto-alegre
  #TODO: fix page status 404
  def find_by_city(city = String.new)
    url = "http://vejabrasil.abril.com.br/#{city}/busca/?area=estabelecimentos&tipo=restaurantes"

    build = Hash.new

    name = String.new
    price = String.new

    document = Nokogiri::HTML(open(url))

    document.css('#results > .box').each do |doc|
      doc.children.css('h3').each do |restaurant|
        name = restaurant.text.gsub!(" - #{restaurant.children.css('span').text}", "")

        restaurant_document  = document = Nokogiri::HTML(open(restaurant.children.css('a').attribute('href')))
        restaurant_document.css("div.caixa").each do |restaurant_values|
          restaurant_values.children.css('ul > li:last > b').remove
          restaurant_values.children.css('ul > li:last > strong').remove
          price = restaurant_values.children.css('ul > li:last').text
          price = (/\(de R\$(.+)\sa\sR\$(.+)\)/).match(price).to_s

          unless price.blank?
            price.gsub!('(de R$ ','')
            price.gsub!(')','')
            price.gsub!('R$ ','')
            price.gsub!('a','+')
            price.gsub!(',','.')
            price = eval("#{price}/2")
            price = ActionController::Base.helpers.number_to_currency(price, :unit => "R$", :separator => ",",:delimiter => ".")

            if name and price
              build[name] = price
            end
          end
        end
      end
    end

    build
  end
end