class LikesController < ApplicationController
  before_action :set_like, only: [:create, :destroy]

  def create
    @like = @declutter.likes.new(user_id: current_user.id)
    @like.save
    # render先にjsファイルを指定
    render :likes
  end

  def destroy
    @like = @declutter.likes.find_by(user_id: current_user.id)
    @like.destroy
    # render先にjsファイルを指定
    render :likes
  end
  
  private
  
  def set_like
    @declutter = Declutter.find(params[:declutter_id])
  end
  
end
