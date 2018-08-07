class UserStocksController < ApplicationController
    def create
        unless current_user.can_add_stock?(params[:stock_ticker])
            flash[:danger] = "Can't add stock to user's portfolio. Either the limit is reached or he already has it in the portfolio"
            redirect_to my_portfolio_path
            return
        end
        stock = Stock.find_by_ticker(params[:stock_ticker])
        if stock.blank?
            stock = Stock.new_from_lookup(params[:stock_ticker])
            stock.save
        end
        @user_stock = UserStock.create(user: current_user, stock: stock)
        flash[:success] = "Stock #{@user_stock.stock.name} was successfully added to portfolio"
        redirect_to my_portfolio_path
    end
end
