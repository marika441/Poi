class LikesController < ApplicationController
  before_action :declutter_params

  def create
    @declutter = Declutter.find(params[:declutter_id])
    @like = @declutter.likes.new(user_id: current_user.id)
    @like.save
    # render先にjsファイルを指定
    render :likes
  end

  def destroy
    @declutter = Declutter.find(params[:declutter_id])
    @like = @declutter.likes.find_by(user_id: current_user.id)
    @like.destroy
    # render先にjsファイルを指定
    render :likes
  end

  private

  def declutter_params
    @declutters = Declutter.find_by(id: params[:declutter_id])
  end

end
