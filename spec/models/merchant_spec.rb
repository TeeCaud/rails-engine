require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'model methods' do
    it 'fuzzy search for merchants' do
      merchant1 = Merchant.create!(name: "Tyler")
      merchant2 = Merchant.create!(name: "Tyrese")
      merchant3 = Merchant.create!(name: "Tyrome")
      merchant4 = Merchant.create!(name: "Tanya")
      merchant5 = Merchant.create!(name: "Tony")

      expect(Merchant.find_all_by_name('ty')).to eq([merchant1, merchant2, merchant3])
      expect(Merchant.find_all_by_name('TY')).to eq([merchant1, merchant2, merchant3])
      expect(Merchant.find_all_by_name('a')).to eq([merchant4])
      expect(Merchant.find_all_by_name('T')).to eq([merchant1, merchant2, merchant3, merchant4, merchant5])
    end
  end
end
