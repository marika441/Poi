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

  describe 'アソシエーションのテスト' do
    context 'Declutterモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:declutters).macro).to eq :has_many
      end
    end
    context 'Declutter_commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:declutter_comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Bookmarkモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:bookmarks).macro).to eq :has_many
      end
    end
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている(follower_id)' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it '1:Nとなっている(followed_id)' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end
  end
end