FactoryBot.define do
  factory :order_address do
    num_three = Faker::Number.number(digits: 3)
    num_four = Faker::Number.number(digits: 4)

    postal_code   { "#{num_three}-#{num_four}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city          { Gimei.city.kanji }
    address       { Gimei.town.kanji }
    building      { Faker::Address.building_number }
    phone_number  { Faker::Number.number(digits: 10) }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
