class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id

  belongs_to :merchant

  def self.find_by_name(name)
    where('lower(name) like ?', "%#{name.downcase}%").order('name').first
  end
end
