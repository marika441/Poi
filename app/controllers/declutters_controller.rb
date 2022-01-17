class DecluttersController < ApplicationController

  def new
    @declutter = Declutter.new
  end

  def create
    @declutter = Declutter.new(declutter_params)
    @declutter.user_id = current_user.id
    user = User.find(current_user.id)

    totalExp = user.exp_point
    totalExp += @declutter.point

    user.exp_point = totalExp
    user.update(exp_point: totalExp)

    nextlevel = NextLevel.find_by(level: user.level + 1);

    if nextlevel.thresold <= user.exp_point
      user.level = user.level + 1
      user.update(level: user.level)
    end
    @declutter.save
    redirect_to declutters_path
  end

  def index
    @declutters = Declutter.all
    # マイページで自分の投稿のみカレンダーに表示
    @mydeclutters = Declutter.where(user_id: current_user.id)
    # @mydeclutters = User.joins(:declutters).where(declutters: { user_id: current_user.id })
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
