# frozen_string_literal:true

class PotatoPrice < ApplicationRecord
  validates :price, :time, presence: true
  validates :time, uniqueness: true

  default_scope { order(time: :asc) }

  def self.min_price_for_day(date_time)
    where(time: date_time.beginning_of_day..date_time.end_of_day).minimum(:price)
  end

  def self.max_price_for_day(date_time)
    where(time: date_time.beginning_of_day..date_time.end_of_day).maximum(:price)
  end
end
