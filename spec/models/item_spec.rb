require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'model methods' do
    it 'can find an item by a name' do
      merchant = Merchant.create!(name: "Tyler")
      item1 = Item.create!(name: 'pizza', description: "yummy yum", unit_price: 24.99, merchant_id: merchant.id)
      item2 = Item.create!(name: 'black_coffee', description: "the best", unit_price: 2.99, merchant_id: merchant.id)
      item3 = Item.create!(name: 'iced_coffee', description: "burr", unit_price: 3.99, merchant_id: merchant.id)

      expect(merchant.items).to eq([item1, item2, item3])
      expect(Item.find_by_name('ffe')).to eq(item2)
    end
  end
end
