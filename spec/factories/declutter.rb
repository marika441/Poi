# ダミーデータの作成
FactoryBot.define do
  factory :declutter do
    caption { Faker::Lorem.characters(number:200) }
    user
  end
end