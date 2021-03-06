# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.tweet_id = params[:tweet_id]
    @comment.user_id = current_user.id
    if @comment.save
      @tweet = @comment.tweet
      @tweet.create_notice_comment!(current_user, @comment.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
