FactoryBot.define do
  factory :purchase_record do
    association :product
    user { product.user }
  end
end