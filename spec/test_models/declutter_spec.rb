require 'rails_helper'

RSpec.describe 'Declutterモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # factoriesで作成したダミーデータを使用
    let(:user) { FactoryBot.create(:user) }
    let!(:declutter) { build(:declutter, user_id: user.id) }

    # test_declutterを作成し、空欄での登録ができるか確認
    subject { test_declutter.valid? }
    let(:test_declutter) { declutter }

      context 'thing_imageカラム' do
      it '空欄でないこと' do
        test_declutter.thing_image = ''
        is_expected.to eq false;
      end
    end
    context 'titleカラム' do
      it '空欄でないこと' do
        test_declutter.title = ''
        is_expected.to eq false;
      end
      it '10文字以下であること' do
        declutter.title = Faker::Lorem.characters(number:11)
        expect(declutter.valid?).to eq false;
      end
    end
    context 'captionカラム' do
      it '空欄でないこと' do
        test_declutter.caption = ''
        is_expected.to eq false;
      end
      it '200文字以下であること' do
        declutter.caption = Faker::Lorem.characters(number:201)
        expect(declutter.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Declutter.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end