FactoryBot.define do
  factory :purchase_destination do

    token        {'tok_abcdefghijk00000000000000000'}
    post_number  {'123-4567'}
    prefecture_id{Faker::Number.between(from: 2, to: 48)}
    municipality {'米花区'}
    address      {'米花町5-1'}
    building_name{'毛利探偵事務所'}
    phone_number {'0120123456'}

  end
end
