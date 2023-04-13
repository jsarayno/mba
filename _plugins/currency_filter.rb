require 'bigdecimal'
require 'bigdecimal/util'

module Jekyll
  module CurrencyFilter
    def currency(input, decimals = 2, symbol = "$")
      input = BigDecimal(input.to_s)
      if decimals == 0
        dollars = input.round(decimals).to_i.to_s
        dollars.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
        "#{symbol}#{dollars}"
      else
        dollars, cents = input.round(decimals).to_s('F').split('.')
        dollars.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
        if cents == '0'
          "#{symbol}#{dollars}.#{'0' * decimals}"
        else
          "#{symbol}#{dollars}.#{cents}"
        end
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::CurrencyFilter)