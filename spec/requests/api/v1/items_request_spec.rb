require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:merchant, 1)
    create_list(:item, 3)
    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item).to have_key(:attributes)

      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'can get one item by its id' do
    create_list(:merchant, 1)
    create_list(:item, 3)
    id = create(:item).id

    get "/api/v1/items/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful
    expect(item).to have_key(:id)
    expect(item).to have_key(:attributes)

    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_a(Integer)
  end

  it 'can create an item' do
    create_list(:merchant, 1)
    visit '/api/v1/items'

    item_params = ({
                name: 'Computer',
                description: 'Macbook Pro',
                unit_price: '1200.99',
                merchant_id: '1'
              })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(book: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq()
  end

  xit 'can edit an item' do

  end

  xit 'can delete an item' do

  end

  xit 'can get the merchant data for a given item ID' do

  end
end
