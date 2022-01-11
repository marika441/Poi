class Declutter < ApplicationRecord

  belongs_to :user
  has_many :declutter_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  #likesテーブル内に引数で渡されたユーザーが存在しているかどうかを確認
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  attachment :thing_image

end