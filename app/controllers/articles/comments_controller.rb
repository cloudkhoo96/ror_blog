class Articles::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @comment
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
            @comment,
            partial: "comments/edit",
            locals: { article: @article, comment: @comment },
          ),
        ]
      end
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      respond_to do |format|
        format.html
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              @comment,
              partial: "comments/comment",
              locals: { comment: @comment },
            ),
          ]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
      format.html { redirect_to article_path(@article) }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end
