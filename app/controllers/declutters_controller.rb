class DecluttersController < ApplicationController

  def new
    @declutter = Declutter.new
  end

  def create
    @declutter = Declutter.new(declutter_params)
    @declutter.user_id = current_user.id
    user = User.find(current_user.id)
    # 現在のユーザーの経験値と得られた投稿ポイントを加算
    totalExp = user.exp_point
    totalExp += @declutter.point
    # 加算した経験値をuserの総経験値を示す変数に入れ直して更新
    user.exp_point = totalExp
    user.update(exp_point: totalExp)
    # nextlevelモデルから現在のuserレベルよりも1高いレコードを取得
    nextlevel = NextLevel.find_by(level: user.level + 1);
    # 探してきたレコードの閾値よりもユーザーの総経験値が高い場合は、レベル1増やして更新
    if nextlevel.thresold <= user.exp_point
      user.level = user.level + 1
      user.update(level: user.level)
    end
    if @declutter.save
      redirect_to declutters_path
    else
      render :new
    end
  end

  def index
    @declutters = Declutter.page(params[:page]).reverse_order.per(9)
    # ユーザーのレベルごとのランキングを表示
    @user_ranks = User.order(level: :desc).limit(3).pluck(:id, :level, :name)
    # マイページで自分の投稿のみカレンダーに表示
    @mydeclutters = Declutter.where(user_id: current_user.id)
  end

  def show
    @declutter = Declutter.find(params[:id])
    @declutter_comment = DeclutterComment.new
  end

  def edit
    @declutter = Declutter.find(params[:id])
  end

  def destroy
    @declutter = Declutter.find(params[:id])
    @declutter.destroy
    redirect_to declutters_path
  end

  def update
    @declutter = Declutter.find(params[:id])
    @declutter.update(declutter_params)
    redirect_to declutter_path(@declutter.id)
  end

  private

  def declutter_params
    params.require(:declutter).permit(:title, :thing_image, :caption, :point, :start_date, :end_date, :user_id)
  end

end
