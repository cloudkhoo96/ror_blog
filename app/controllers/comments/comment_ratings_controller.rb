class Comments::CommentRatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  def create
    @comment.comment_ratings.create(user: current_user)
    render_turbo_stream_update
  end

  def destroy
    @comment.comment_ratings.find_by(user: current_user).destroy
    render_turbo_stream_update
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def render_turbo_stream_update
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.update(
          "comment_like_count_#{@comment.id}",
          partial: "comments/like_count",
          locals: { comment: @comment }
        )
      }
    end
  end
end