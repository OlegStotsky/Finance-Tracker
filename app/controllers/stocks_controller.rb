class StocksController < ApplicationController
    def search
        unless params[:stock].present?
            flash[:danger] = "You have entered empty search string"
            redirect_to my_portfolio_path
            return
        end
        begin
            @stock = Stock.new_from_lookup(params[:stock])
            respond_to do |format|
                format.js { render partial: 'users/result' }
            end
        rescue NilStockException => e
            flash[:danger] = e.message
            redirect_to my_portfolio_path
        end
    end
end