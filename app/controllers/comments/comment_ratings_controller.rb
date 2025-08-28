class Comments::CommentRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  def create
    @comment.comment_ratings.create(user: current_user)
  end

  def destroy
    @comment.comment_ratings.find_by(user: current_user).destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
end