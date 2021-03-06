# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# CSVからnext_levelテーブルのレベル・閾値を取り込み
require "csv"

CSV.foreach('db/next_level.csv') do |info|
  NextLevel.create(:level => info[0], :thresold => info[1])
end

# User
User.create!(:name => "はな", :email => "example1@example.com", :password => "123456")
User.create!(:name => "たろ", :email => "example2@example.com", :password => "123456")
User.create!(:name => "ゆう", :email => "example3@example.com", :password => "123456")
User.create!(:name => "はる", :email => "example4@example.com", :password => "123456")
User.create!(:name => "とも", :email => "example5@example.com", :password => "123456")