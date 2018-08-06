class Stock < ApplicationRecord
    def self.new_from_lookup(ticker_symbol)
        looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
        unless looked_up_stock
            raise NilStockException.new
        end
        new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    end
end

class NilStockException < Exception
    def message
        "Couldn't find stock with provided name. Please try again"
    end
end