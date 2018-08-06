class StocksController < ApplicationController
    def search
        if params[:stock].present?
            begin
                @stock = Stock.new_from_lookup(params[:stock])
                render 'users/my_portfolio'
            rescue NilStockException => e
                flash[:danger] = e.message
                redirect_to my_portfolio_path
            end
        else
            flash[:danger] = "You have entered empty search string"
            redirect_to my_portfolio_path
        end
    end
end