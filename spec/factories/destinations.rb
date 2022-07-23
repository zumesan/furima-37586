FactoryBot.define do
  factory :destination, class:Destination do
    post_number           {"1234567"}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}
    municipality          {"大市"}
    address               {"小町9-1"}
    building_name         {""}
    phone_number          {"09012345678"}

    #association :purchase_record

  end
end
