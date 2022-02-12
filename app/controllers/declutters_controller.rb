class DecluttersController < ApplicationController
  before_action :set_declutter, only: [:show, :edit, :destroy, :update]

  def new
    @declutter = Declutter.new
  end

  def create
    @declutter = Declutter.new(declutter_params)
    @declutter.user_id = current_user.id
    if @declutter.save
      user = User.find(current_user.id)

      totalExp = user.exp_point + @declutter.point

      user.exp_point = totalExp
      user.update(exp_point: totalExp)
      # nextlevelモデルから現在のuserレベルよりも1高いレコードを取得
      nextlevel = NextLevel.find_by(level: user.level + 1);
      # 探してきたレコードの閾値よりもユーザーの総経験値が高い場合は、レベル1増やして更新
      if nextlevel.thresold <= user.exp_point
        user.level = user.level + 1
        user.update(level: user.level)
        flash[:levelup]="レベルアップ！"
      end
      flash[:notice]="今日のPoi!を投稿しました"
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
    @declutter_comment = DeclutterComment.new
  end

  def edit
    if @declutter.user == current_user
      render :edit
    else
      redirect_to declutters_path
    end
  end

  def destroy
    @declutter.destroy
    redirect_to declutters_path
  end

  def update
    @declutter.update(declutter_params)
    flash[:notice]="投稿を変更しました"
    redirect_to declutter_path(@declutter.id)
  end

  private

  def declutter_params
    params.require(:declutter).permit(:title, :thing_image, :caption, :point, :start_date, :end_date, :user_id)
  end

  def set_declutter
    @declutter = Declutter.find(params[:id])
  end

end
