require 'open-uri'
require 'nokogiri'

class Hotel
  attr_accessor :name, :price, :trip

  def initialize(name = String.new, value = String.new)
    @name = name
    @value = value
  end

  def find_by_city(city)
    build = Hash.new

    original_price = String.new
    actual_price = String.new

    name = String.new
    price = String.new

    document = Nokogiri::HTML(open("http://www.hotelurbano.com.br/busca?q=#{city}"))

    document.css('.dados-oferta-mini').each do |doc|
      name = doc.children.css('.dados-textuais-mini > h2 > span').text

      original_price = doc.children.css('.valor-oferta-mini > p.preco-original-mini').text
      actual_price =  doc.children.css('.valor-oferta-mini > p.preco-atual-mini').text

      price =  original_price.blank? ? actual_price : original_price
      price.gsub!(/[a-zA-z]|\ |\$/, '')
      build[name] = ActionController::Base.helpers.number_to_currency(price, :unit => "R$", :separator => ",",:delimiter => ".")
    end

    build
  end
end