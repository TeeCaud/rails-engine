class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items, dependent: :destroy

  def self.find_all_by_name(name)
    where('lower(name) like ?', "%#{name.downcase}%")
  end
end
