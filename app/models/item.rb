class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  belongs_to :merchant

  def self.find_by_name(input)
    where('lower(name) like ?', "%#{input.downcase}%").order('name').first
  end
end
