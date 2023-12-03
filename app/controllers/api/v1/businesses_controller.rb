module Api
  module V1
    class BusinessesController < ApplicationController
      def index
        businesses = Business.available_shares(@current_user)
        render json: success_response(businesses, 'Successfully business share fetched'),
               status: :ok
      rescue => e
        Rails.logger.error("Business shares fetch failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      def create
        business = @current_user.businesses.create!(business_params)
        render json: success_response(business, 'Successfully business share created'),
               status: :created
      rescue => e
        Rails.logger.error("Business entity creation failed due to #{e.full_message}")
        render json: failed_response(e.message), status: :unprocessable_entity
      end

      private

      def business_params
        params.permit(
        :name,
        :shares_available
        )
      end
    end
  end
end
