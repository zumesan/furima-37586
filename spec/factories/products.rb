FactoryBot.define do
  factory :product do
    product_name          {Faker::Name.name} #ランダムな名前を生成
    product_info          {Faker::Lorem.sentence} #ランダムな文章を生成
    category_id           {Faker::Number.between(from: 2, to: 11)} #ランダムな数字を生成
    state_id              {Faker::Number.between(from: 2, to: 7)}
    shipping_fee_id       {Faker::Number.between(from: 2, to: 3)}
    prefecture_id         {Faker::Number.between(from: 2, to: 48)}
    date_of_shipping_id   {Faker::Number.between(from: 2, to: 4)}
    price                 {Faker::Number.between(from: 300, to: 9999999)}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/IMG_0251.jpeg'), filename: 'IMG_0251.jpeg')
    end
  end

  #trait :image do
    #after(:build) do |product|
      #File.open("#{Rails.root}/public/images/IMG_0251.jpeg") do |f|
        #item.images.attach(io: f, filename: "IMG_0251.jpeg", content_type: 'image/jpeg')
      #end
    #end
  #end
end
