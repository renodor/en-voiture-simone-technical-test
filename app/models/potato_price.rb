class PotatoPrice < ApplicationRecord
  validates :price, :time, presence: true
  validates :time, uniqueness: true
end
