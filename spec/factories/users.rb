FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    nickname              { Faker::Name.initials }
    last_name             { Gimei.name.last.kanji }
    first_name            { Gimei.name.first.hiragana }
    last_name_kana        { Gimei.name.last.katakana }
    first_name_kana       { Gimei.name.first.katakana }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: Date.today.prev_year(5)) }
  end
end
