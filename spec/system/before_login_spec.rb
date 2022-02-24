require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容のテスト' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ロゴのリンクの内容が正しい' do
        logo_link = find_all('a')[1].native.inner_text
        expect(page).to have_link logo_link, href: root_path
      end
      it 'Sign Upリンクの内容が正しい' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
      it 'Log Inリンクの内容が正しい' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'ゲストログインリンクの内容が正しい' do
        guest_log_in_link = find_all('a')[4].native.inner_text
        expect(page).to have_link guest_log_in_link, href: homes_guest_sign_in_path
      end
      it 'Aboutリンクの内容が正しい' do
        about_link = find_all('a')[5].native.inner_text
        expect(page).to have_link about_link, href: homes_about_path
      end
    end

    describe 'アバウト画面のテスト' do
      before do
        visit '/homes/about'
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/homes/about'
        end
      end
    end

    describe 'ヘッダーのテスト: ログインしていない場合' do
      before do
        visit root_path
      end

      context 'リンクの内容を確認' do
        subject { current_path }

        it 'ロゴを押すと、トップ画面に遷移する' do
          logo_link = find_all('a')[1].native.inner_text
          click_link logo_link
          is_expected.to eq '/'
        end
        it 'Sign Upを押すと、新規登録画面に遷移する' do
          signup_link = find_all('a')[2].native.inner_text
          click_link signup_link
          is_expected.to eq '/users/sign_up'
        end
        it 'Log Inを押すと、ログイン画面に遷移する' do
          login_link = find_all('a')[3].native.inner_text
          click_link login_link
          is_expected.to eq '/users/sign_in'
        end
        it 'Aboutを押すと、About画面に遷移する' do
          about_link = find_all('a')[5].native.inner_text
          click_link about_link
          is_expected.to eq '/homes/about'
        end
      end
    end

    describe 'ユーザ新規登録のテスト' do
      before do
        visit new_user_registration_path
      end

      context '新規登録成功のテスト' do
        before do
          fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'password'
          fill_in 'user[password_confirmation]', with: 'password'
        end

        it '正しく新規登録される' do
          expect { click_button 'Sign up' }.to change(User.all, :count).by(1)
        end
        it '新規登録後のリダイレクト先が、投稿一覧となっている' do
          click_button 'Sign up'
          expect(current_path).to eq '/declutters'
        end
      end
    end

    describe 'ユーザログイン' do
      let(:user) { FactoryBot.create(:user) }

      before do
        visit new_user_session_path
      end

      context 'ログイン成功のテスト' do
        before do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_button 'Log in'
        end

        it 'ログイン後のリダイレクト先が、投稿一覧になっている' do
          expect(current_path).to eq '/declutters'
        end
      end

      context 'ログイン失敗のテスト' do
        before do
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'Log in'
        end

        it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
          expect(current_path).to eq '/users/sign_in'
        end
      end
    end

    describe 'ユーザーログアウト' do
      let(:user) { FactoryBot.create(:user) }

      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        logout_link = find_all('a')[3].native.inner_text
        click_link logout_link
      end

      context 'ログアウト機能のテスト' do
        it 'ログアウト後のリダイレクト先が、トップになっている' do
          expect(current_path).to eq '/'
        end
      end
    end

  end
end