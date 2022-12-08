# frozen_string_literal:true

# A bit long but I don't want to simply use "Transaction"
# as it is used by ActiveRecord
class PotatoTransaction < ApplicationRecord
  validates :quantity, :price, presence: true

  belongs_to :user

  # "direction" is not the most appropriate name but is the best I could find
  # "type" would be better but is reserved and can't be used as an attribute name in Rails
  enum direction: %i[sell buy]
end
