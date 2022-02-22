require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # factoriesで作成したダミーデータを使用
  let(:user) { FactoryBot.create(:user) }
  # test_declutterを作成し、空欄での登録ができるか確認
  subject { test_user.valid? }
  let(:test_user) { user }

  describe 'バリデーションのテスト' do
    context 'nameカラム' do
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '2文字以上であること' do
        user.name = Faker::Lorem.characters(number: 1)
        expect(user.valid?).to eq false
      end
      it '10文字以下であること' do
        user.name = Faker::Lorem.characters(number:11)
        expect(user.valid?).to eq false;
      end
    end
    context 'introductionカラム' do
      it '50文字以下であること' do
        user.introduction = Faker::Lorem.characters(number:51)
        expect(user.valid?).to eq false;
      end
    end
  end
end