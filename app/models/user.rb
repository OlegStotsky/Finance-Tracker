class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end
  
  def under_stock_limit?
    stocks.count < 10
  end
  
  def can_add_stock?(ticker_symbol)
    under_stock_limit? and not stock_already_added?(ticker_symbol)
  end
  
  def full_name
    return "#{first_name} #{last_name}".strip if first_name || last_name
    "Anonymous"
  end
end
