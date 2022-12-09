# frozen_string_literal:true

class PotatoPrice < ApplicationRecord
  validates :price, :time, presence: true
  validates :time, uniqueness: true

  scope :ascend_by_time, -> { order(:time) }
  scope :descend_by_time, -> { order(time: :desc) }
  scope :at_date, ->(date) { where(time: date.beginning_of_day..date.end_of_day) }

  def self.min_max_at_date(date)
    potato_prices = PotatoPrice.at_date(date).descend_by_time
    max_potato_price = potato_prices.first
    min_potato_price = potato_prices.last
    max_diff = 0

    potato_prices.each do |potato_price|
      if potato_price.price >= max_potato_price.price
        max_potato_price = potato_price
      elsif max_potato_price.price - potato_price.price > max_diff
        min_potato_price = potato_price
        max_diff = max_potato_price.price - potato_price.price
      end
    end

    {
      min: min_potato_price,
      max: max_potato_price
    }
  end
end
