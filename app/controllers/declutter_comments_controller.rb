class DeclutterCommentsController < ApplicationController

  def create
    declutter = Declutter.find(params[:declutter_id])
    comment = current_user.declutter_comments.new(declutter_comment_params)
    comment.declutter_id = declutter.id
    comment.save
    redirect_to declutter_path(declutter)
  end

  def destroy
    DeclutterComment.find_by(id: params[:id]).destroy
    redirect_to declutter_path(params[:declutter_id])
  end

  private

  def declutter_comment_params
    params.require(:declutter_comment).permit(:comment)
  end

end
