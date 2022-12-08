# frozen_string_literal:true

# A bit long but I don't want to simply use "Transaction"
# as it is used by ActiveRecord
class PotatoTransaction < ApplicationRecord
  validates :quantity, :price, :time, :direction, presence: true
  validates :time, uniquness: true, { scope: :user_id }
  validate :is_allowed

  belongs_to :user

  # "direction" is not the most appropriate name but is the best I could find
  # "type" would be better but is reserved and can't be used as an attribute name in Rails
  enum direction: { buy: 0, sell: 1 }

  scope :today, -> { where(created_at: DateTime.current.beginning_of_day..DateTime.current.end_of_day) }

  before_validation :add_price

  private

  def add_price
    price = PotatoPrice.find_by(time: time)&.price

    # Should probably raise error here if price is nil

    self.price = price
  end

  def is_allowed
    if direction == 'buy'
      quantity_bought_today = user.bought.select(:quantity).sum(&:quantity)
      errors.add(:quantity, "maximum is reached. You already bought #{quantity_bought_today} potatos today. You can only buy 100 potatos a day!!") if (quantity_bought_today + quantity) > 100
    else
      # Check that user currently has enought potatos to sell
    end
  end
end
