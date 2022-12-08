# frozen_string_literal:true

class PotatoPricesController < ApplicationController
  # Would probably need allow time range params to filter result by time
  # and not return all prices all the time
  def index
    @potato_prices = PotatoPrice.all.select(:price, :time, :id)

    render json: @potato_prices.to_json
  end
end
