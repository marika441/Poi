# ダミーデータの作成
FactoryBot.define do
  factory :declutter do
    title { Faker::Lorem.characters(number: 5) }
    caption { Faker::Lorem.characters(number: 20) }
    thing_image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.jpg")) }
    user
  end
end