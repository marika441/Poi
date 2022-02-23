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

  end
end