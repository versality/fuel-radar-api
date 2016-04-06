require 'open-uri'
require 'nokogiri'

class LNafta
  def initialize
    @doc = Nokogiri::HTML(open('http://www.lnafta.lv/lv/start/aktualitates-latvijasnafta').read)
  end

  def prices
    gas_price = @doc.css('.gas .price').first
    gas_address  = @doc.css('.address').first

    d_price = @doc.css('.gas .price').last
    d_address  = @doc.css('.address').last

    {
      'lnafta' => {
        '95' => {
          price: /[\d\.\,]*/.match(gas_price.text)[0].to_f,
          address: gas_address.text
        },

        'd' => {
          price: /[\d\.\,]*/.match(d_price.text)[0].to_f,
          address: d_address.text
        }
      }
    }
  end
end
