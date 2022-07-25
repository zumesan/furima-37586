FactoryBot.define do
  factory :destination, class:Destination do

    association :purchase_record

  end
end