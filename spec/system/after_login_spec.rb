require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let!(:declutter) { FactoryBot.create(:declutter, user: user) }
  let!(:other_declutter) { FactoryBot.create(:declutter, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認:' do
      subject { current_path }

      it 'Mypageを押すと、ユーザー詳細画面に遷移する' do
        mypage_link = find_all('a')[2].native.inner_text
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'Aboutを押すと、About画面に遷移する' do
        about_link = find_all('a')[4].native.inner_text
        click_link about_link
        is_expected.to eq '/homes/about'
      end
      it 'みんなのPoi!を押すと、投稿一覧詳細画面に遷移する' do
        declutter_index_link = find_all('a')[5].native.inner_text
        click_link declutter_index_link
        is_expected.to eq '/declutters'
      end
      it '今日のPoi!を押すと、新規投稿画面に遷移する' do
        declutter_new_link = find_all('a')[6].native.inner_text
        click_link declutter_new_link
        is_expected.to eq '/declutters/new'
      end
      it 'Usersを押すと、ユーザー一覧画面に遷移する' do
        users_link = find_all('a')[7].native.inner_text
        click_link users_link
        is_expected.to eq '/users'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit declutters_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/declutters'
      end
      it '自分と他の人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(declutter.user)
        expect(page).to have_link '', href: user_path(other_declutter.user)
      end
      it '自分の投稿と他の人の投稿画像のリンク先が正しい' do
        expect(page).to have_link declutter.thing_image, href: declutter_path(declutter)
        expect(page).to have_link other_declutter.thing_image, href: declutter_path(other_declutter)
      end
    end

    context '投稿成功のテスト' do

      before do
        visit new_declutter_path
        find('input[type="file"]').click
        attach_file "declutter[thing_image]", "app/assets/images/logo.jpg"
        fill_in 'declutter[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'declutter[caption]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '手放す' }.to change(user.declutters, :count).by(1)
      end
      it 'リダイレクト先が、投稿一覧画面になる' do
        click_button '手放す'
        expect(current_path).to eq '/declutters'
      end
    end
  end
end