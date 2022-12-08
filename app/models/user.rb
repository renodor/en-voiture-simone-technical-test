# frozen_string_literal:true

class User < ApplicationRecord
  validates :username, presence: true

  has_many :potato_transactions, dependent: :destroy

  # Probably an easier way to get that using scoped relation
  def transactions_at_date(date_time)
    potato_transactions.where(time: date_time.beginning_of_day..date_time.end_of_day)
  end

  def bought_at_date(date_time)
    transactions_at_date(date_time).where(direction: 0)
  end

  def transactions_today
    PotatoTransaction.today.where(user_id: id)
  end

  def bought_today
    transactions_today.where(direction: 0)
  end
end
