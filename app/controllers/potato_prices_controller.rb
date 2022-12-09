# frozen_string_literal:true

class PotatoPricesController < ApplicationController
  # Would probably need allow time range params to filter result by time
  # and not return all prices all the time
  def index
    potato_prices = PotatoPrice.ascend_by_time.select(:price, :time, :id)

    render json: potato_prices.to_json
  end

  def best_deal_at_date
    date = Date.parse(params[:date]) # TODO: check date format is correct before parsing
    min_max_at_date = PotatoPrice.min_max_at_date(date)

    if min_max_at_date[:success?]
      min_price = min_max_at_date[:min].price
      max_price = min_max_at_date[:max].price

      render json: {
        min_price: min_price,
        max_price: max_price,
        max_profit: (max_price * PotatoTransaction::MAX_DAILY_QUANTITY) - (min_price * PotatoTransaction::MAX_DAILY_QUANTITY)
      }
    else
      render json: {
        error: 'Not enough price data to calculate best deal for this date'
      }
    end
  end
end
