class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks
    
    def self.find_by_ticker(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
    
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