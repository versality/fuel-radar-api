require 'open-uri'
require 'nokogiri'

class Neste
  def initialize
    @doc = Nokogiri::HTML(open('http://www.nesteoil.lv/lv/content/degvielas-cenas'))
  end

  def prices
    first  = @doc.css('table tr:nth-child(2) td')
    second = @doc.css('table tr:nth-child(3) td')
    third  = @doc.css('table tr:nth-child(4) td')

    {
      'neste' => {
        '95' => {
          price: /[\d\.\,]*/.match(first[1].text)[0].to_f,
          address: first[2].text
        },

        '98' => {
          price: /[\d\.\,]*/.match(second[1].text)[0].to_f,
          address: second[2].text
        },

        'd' => {
          price: /[\d\.\,]*/.match(third[1].text)[0].to_f,
          address: third[2].text
        }
      }
    }
  end
end
