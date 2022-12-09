# frozen_string_literal:true

class User < ApplicationRecord
  validates :username, presence: true

  MAX_DAILY_QUANTITY = 100
end
