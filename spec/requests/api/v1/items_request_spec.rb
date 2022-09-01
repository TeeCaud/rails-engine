require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)
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
    merchant_id = create(:merchant).id
    create_list(:item, 3, merchant_id: merchant_id)
    id = create(:item, merchant_id: merchant_id).id
    # bad_id = create(:item, merchant_id: merchant_id + 1)

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

    # get "/api/v1/items/#{bad_id}"
    # expect(response).to_not be_successful
  end

  it 'can create an item' do
    merchant_id = create(:merchant).id
    get '/api/v1/items'

    item_params = ({
                name: 'Computer',
                description: 'Macbook Pro',
                unit_price: '1200.99',
                merchant_id: merchant_id
              })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price.to_s).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'can update an item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id

    item_params = { name: "Cell Phone" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item: item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item[:name]).to eq("Cell Phone")
  end

  it 'cant update an item' do
    # How would we write this test?
    item_params = { name: "Cell Phone" }
    patch "/api/v1/items/:id", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to have_http_status(404)
  end

  it 'can delete an item' do
    merchant_id = create(:merchant).id
    id = create(:item, merchant_id: merchant_id).id
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find an item with a name fragment' do
    merchant = create(:merchant)
    item1 = Item.create!(name: 'pizza', description: "yummy yum", unit_price: 24.99, merchant_id: merchant.id)
    item2 = Item.create!(name: 'black_coffee', description: "the best", unit_price: 2.99, merchant_id: merchant.id)
    item3 = Item.create!(name: 'iced_coffee', description: "burr", unit_price: 3.99, merchant_id: merchant.id)

    get '/api/v1/items/find?name=oFf'

    expect(response).to be_successful
    found_items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(found_items).to be_a(Hash)

    get '/api/v1/items/find?name=abc'
    expect(found_items).to be_a(Hash)
  end
end
