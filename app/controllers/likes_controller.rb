class LikesController < ApplicationController

  def create
    declutter = Declutter.find(params[:declutter_id])
    like = current_user.likes.new(declutter_id: declutter.id)
    like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    declutter = Declutter.find(params[:declutter_id])
    like = current_user.likes.find_by(declutter_id: declutter.id)
    like.destroy
    redirect_back(fallback_location: root_path)
  end

end
