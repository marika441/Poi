class RelationshipsController < ApplicationController
  before_action :set_rerationship, only: [:followings, :followers]

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
  end

  def followers
  end
  
  private
  
  def set_rerationship
    user = User.find(params[:user_id])
    @followings = user.followings
    @followers = user.followers
  end

end
