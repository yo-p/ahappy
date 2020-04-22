# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    # ログインしているuserのお気に入りを全件取得
    @favorites = Favorite.where(user_id: current_user.id).all.recent.page(params[:page])
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.build(tweet_id: params[:tweet_id])
    favorite.save
    @tweet.create_notice_favorite!(current_user)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = Favorite.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    favorite.destroy
  end
end
