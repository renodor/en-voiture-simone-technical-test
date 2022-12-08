class PotatoPrice < ApplicationRecord
  validates :prce, :date, presence: true
end
