class BookmarksController < ApplicationController

  def  index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def create
    @declutter = Declutter.find(params[:declutter_id])
    @bookmark = @declutter.bookmarks.new(user_id: current_user.id)
    @bookmark.save
    redirect_back(fallback_location:root_path)
  end

  def destroy
    @declutter = Declutter.find(params[:declutter_id])
    @bookmark = @declutter.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy
    redirect_back(fallback_location:root_path)
  end
  
end
