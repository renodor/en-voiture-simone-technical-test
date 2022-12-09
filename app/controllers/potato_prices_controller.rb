# frozen_string_literal:true

class PotatoPricesController < ApplicationController
  def index
    return render json: { error: 'date param is missing' } unless params[:date] # TODO: refacto

    date = Date.parse(params[:date]) # TODO: check date format is correct before parsing
    potato_prices = PotatoPrice.at_date(date).ascend_by_time.select(:price, :time, :id)

    render json: potato_prices.to_json
  end

  def best_deal_at_date
    return render json: { error: 'date param is missing' } unless params[:date]

    date = Date.parse(params[:date]) # TODO: check date format is correct before parsing
    min_max_at_date = PotatoPrice.min_max_at_date(date)

    if min_max_at_date[:success?]
      min_price = min_max_at_date[:min].price
      max_price = min_max_at_date[:max].price

      render json: {
        min_price: min_price,
        max_price: max_price,
        max_profit: (max_price * PotatoTransactionMAX_DAILY_QUANTITY) - (min_price * PotatoTransactionMAX_DAILY_QUANTITY)
      }
    else
      render json: {
        error: 'Not enough price data to calculate best deal for this date'
      }
    end
  end
end
