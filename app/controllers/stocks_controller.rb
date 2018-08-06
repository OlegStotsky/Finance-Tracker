class StocksController < ApplicationController
    def search
        unless params[:stock].present?
            flash.now[:danger] = "You have entered empty search string"
            render partial: 'users/result'
            return
        end
        begin
            @stock = Stock.new_from_lookup(params[:stock])
            respond_to do |format|
                format.js { render partial: 'users/result' }
            end
        rescue NilStockException => e
            flash.now[:danger] = e.message
            render partial: 'users/result'
        end
    end
end