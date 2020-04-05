# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.tweet_id = params[:tweet_id]
    @comment.user_id = current_user.id
    if @comment.save
      #通知機能
      @tweet = @comment.tweet
      @tweet.create_notice_comment!(current_user, @comment_id)
      #######
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = Comment.find_by(tweet_id: params[:tweet_id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
