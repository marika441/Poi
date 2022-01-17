class HomesController < ApplicationController

  def top
  end

  def about
  end

  def new_guest
    # emailでユーザーが見つからない場合に作成
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      # ランダムで文字列を生成
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
    sign_in user
    redirect_to declutters_path
  end

end
