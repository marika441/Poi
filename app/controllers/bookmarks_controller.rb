class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:create, :destroy]

  def  index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def create
    @bookmark = @declutter.bookmarks.new(user_id: current_user.id)
    @bookmark.save
    redirect_back(fallback_location:root_path)
  end

  def destroy
    @bookmark = @declutter.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy
    redirect_back(fallback_location:root_path)
  end
  
  private
  
  def set_bookmark
    @declutter = Declutter.find(params[:declutter_id])
  end
  
end
