class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:create, :destroy]

  def  index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def create
    @bookmark = @declutter.bookmarks.new(user_id: current_user.id)
    @bookmark.save
    # render先にjsファイルを指定
    render :bookmarks
  end

  def destroy
    @bookmark = @declutter.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy
    # render先にjsファイルを指定
    render :bookmarks
  end

  private

  def set_bookmark
    @declutter = Declutter.find(params[:declutter_id])
  end

end
