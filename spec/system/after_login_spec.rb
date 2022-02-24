require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認:' do
      subject { current_path }

      it 'ロゴを押すと、トップ画面に遷移する' do
        logo_link = find_all('a')[1].native.inner_text
        click_link logo_link
        is_expected.to eq '/'
      end
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
end