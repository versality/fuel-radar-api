require 'open-uri'
require 'nokogiri'

class Statoil
  def initialize
    @doc = Nokogiri::HTML(open('http://www.statoil.lv/lv_LV/pg1334072745785/private/Degviela/degvielas-cenas.html'))
  end

  def prices
    column = @doc.css('.fuelprices tbody tr td')

    {
      'statoil' => {
        '95' => {
          price: /[\d\.\,]*/.match(column[0].text)[0].to_f,
          address: /(?<=\()(.*)(?=\))/.match(column[1].text)[0]
        },

        '98' => {
          price: /[\d\.\,]*/.match(column[2].text)[0].to_f,
          address: /(?<=\()(.*)(?=\))/.match(column[3].text)[0]
        },

        'diesel' => {
          price: /[\d\.\,]*/.match(column[4].text)[0].to_f,
          address: /(?<=\()(.*)(?=\))/.match(column[5].text)[0]
        },

        'diesel plus' => {
          price: /[\d\.\,]*/.match(column[6].text)[0].to_f,
          address: /(?<=\()(.*)(?=\))/.match(column[7].text)[0]
        },

        'gas' => {
          price: /[\d\.\,]*/.match(column[8].text)[0].to_f,
          address: /(?<=\()(.*)(?=\))/.match(column[9].text)[0]
        }
      }
    }
  end
end
