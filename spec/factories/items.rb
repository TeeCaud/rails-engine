FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyString" }
    unit_price { "MyFloat" }
    merchant_id { Merchant.first.id }
  end
end
