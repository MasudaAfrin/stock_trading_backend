module Api
  module V1
    class StockTradesController < ApplicationController
      def index
        stock_trades = @current_user.stock_requests.order(id: :desc)
        render json: success_response(stock_trades, 'Trade request is sent successfully'),
               status: :ok
      rescue => e
        Rails.logger.error("Stock trade fetch failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      def create
        business = Business.find_by(id: stock_trade_params[:business_id])
        unless business
          render json: failed_response('Available business is not found'),
                 status: :not_found
        end
        trade = business.stock_trades.create!(stock_trade_params.merge!(buyer_id: @current_user.id))
        render json: success_response(trade, 'Trade request is sent successfully'),
               status: :created
      rescue => e
        Rails.logger.error("Stock trade creation failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      def accept
        stock = StockTrade.find(params[:stock_trade_id])
        stock.update!(trade_status: :accepted)
        render json: success_response(stock, 'Trade request is accepted successfully'),
              status: :ok
      rescue => e
        Rails.logger.error("Stock trade accept failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      def reject
        stock = StockTrade.find(params[:stock_trade_id])
        stock.update!(trade_status: :rejected)
        render json: success_response(stock, 'Trade request is rejected successfully'),
               status: :ok
      rescue => e
        Rails.logger.error("Stock trade reject failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      private

      def stock_trade_params
        params.permit(:price,
                      :quantity,
                      :business_id
                      )
      end
    end
  end
end
