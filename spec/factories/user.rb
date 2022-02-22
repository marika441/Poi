# ダミーデータの作成
FactoryBot.define do
  factory :user do
    name { 'test' }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end