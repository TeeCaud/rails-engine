require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

    it 'can get one merchant by its id' do
      create_list(:merchant, 3)
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      response_body = JSON.parse(response.body, symbolize_names: true)
      merchant = response_body[:data]
      expect(response).to be_successful
      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:attributes)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'can find all merchants by name' do
    merchant1 = Merchant.create!(name: "Tyler")
    merchant2 = Merchant.create!(name: "Tyrese")
    merchant3 = Merchant.create!(name: "Tyrome")
    merchant4 = Merchant.create!(name: "Tanya")
    merchant5 = Merchant.create!(name: "Tony")
    input = "Ty"

    get "/api/v1/merchants/find_all?name=#{input}"

    expect(response).to be_successful

    details = JSON.parse(response.body, symbolize_names: true)

    expect(details[:data].count).to eq(3)
    expect(details[:data][0][:attributes][:name]).to eq("Tyler")
  end
end
