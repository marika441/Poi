class DeclutterCommentsController < ApplicationController

  def create
    @declutter = Declutter.find(params[:declutter_id])
    @declutter_comment = DeclutterComment.new(declutter_comment_params)
    @declutter_comment.declutter_id = @declutter.id
    @declutter_comment.user_id = current_user.id
    @declutter_comment.save
    # render先にjsファイルを指定
    render :declutter_comments
  end

  def destroy
    @declutter = Declutter.find(params[:declutter_id])
    DeclutterComment.find_by(id: params[:id]).destroy
    # render先にjsファイルを指定
    render :declutter_comments
  end

  private

  def declutter_comment_params
    params.require(:declutter_comment).permit(:comment)
  end

end
