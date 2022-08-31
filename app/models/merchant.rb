class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy

  # def find_items
  #   binding.pry
  # end
end
