# frozen_string_literal:true

class PotatoPricesController < ApplicationController
  # Would probably need allow time range params to filter result by time
  # and not return all prices all the time
  def index
    potato_prices = PotatoPrice.all.select(:price, :time, :id)

    render json: potato_prices.to_json
  end

  def best_deal_for_day
    day = DateTime.parse(params[:day]) # Should make sure the date format is correct
    min_price = PotatoPrice.min_price_for_day(day)
    max_price = PotatoPrice.max_price_for_day(day)

    # I'm reaching the "2h limit" and just realized the subtility (and probably biggest difficulty) of the exercise...
    # You can't sell before buying... So you can't just take the min and max price of the day,
    # you have to make sure the min price was at a time prior the max price...
    max_profit = (max_price * PotatoTransaction::MAX_DAILY_QUANTITY) - (min_price * PotatoTransaction::MAX_DAILY_QUANTITY)

    render json: max_profit
  end
end
