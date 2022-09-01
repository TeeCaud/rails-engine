class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy

  def self.find_all_by_name(input)
    where('lower(name) like ?', "%#{input.downcase}%")
  end
end
