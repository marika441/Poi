class DeclutterCommentsController < ApplicationController
  before_action :set_declutter_comment, only: [:create, :destroy]

  def create
    @declutter_comment = DeclutterComment.new(declutter_comment_params)
    @declutter_comment.declutter_id = @declutter.id
    @declutter_comment.user_id = current_user.id
    @declutter_comment.save
    # render先にjsファイルを指定
    render :declutter_comments
  end

  def destroy
    DeclutterComment.find_by(id: params[:id]).destroy
    # render先にjsファイルを指定
    render :declutter_comments
  end

  private

  def declutter_comment_params
    params.require(:declutter_comment).permit(:comment)
  end
  
  def set_declutter_comment
    @declutter = Declutter.find(params[:declutter_id])
  end

end
