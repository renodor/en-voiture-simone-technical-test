# frozen_string_literal:true

class PotatoPrice < ApplicationRecord
  validates :price, :time, presence: true
  validates :time, uniqueness: true

  scope :ascend_by_time, -> { order(:time) }
  scope :descend_by_time, -> { order(time: :desc) }
  scope :at_date, ->(date) { where(time: date.beginning_of_day..date.end_of_day) }

  # The pb of the exercise can be resumed by:
  # "find the maximum difference between two prices,
  # making sure that the min price is before (in time) than the max price"

  # For a given date, this method return the two records that have the maximum difference in price
  # making sure that the record with min price is before in time than the record with max price
  # (Inspired by: https://www.techiedelight.com/find-maximum-difference-between-two-elements-array/)
  def self.min_max_at_date(date)
    potato_prices = PotatoPrice.at_date(date).descend_by_time

    # Not the best pattern, but good enought here
    # (in a real API we would calculate this min/max in dedicated service
    # that raise specific errors that we could catch and respond from)
    return { success?: false } if potato_prices.count <= 1

    max_potato_price = potato_prices.first
    min_potato_price = potato_prices.last
    max_diff = 0

    # Traverse potato prices ordered by time
    # keeping track of the record with the max price and the max difference between known prices
    potato_prices.each do |potato_price|
      # If current potato price is higher than the max potato price, we have a new max potato price
      if potato_price.price >= max_potato_price.price
        max_potato_price = potato_price
      # If the difference between the max potato price and the current potato price is higher
      # than the max difference, we have a new max difference (and thus a new min potato price)
      elsif max_potato_price.price - potato_price.price > max_diff
        min_potato_price = potato_price
        max_diff = max_potato_price.price - potato_price.price
      end
    end

    {
      success?: true,
      min: min_potato_price,
      max: max_potato_price
    }
  end
end
