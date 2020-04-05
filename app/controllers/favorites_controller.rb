# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    # ログインしているuserのお気に入りを全件取得
    @favorites = Favorite.where(user_id: current_user.id).all
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.build(tweet_id: params[:tweet_id])
    favorite.save

    # @favorite = Favorite.new(user_id: current_user.id, tweet_id: params[:tweet_id])
    # @favorite.save
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = Favorite.find_by(tweet_id: params[:tweet_id], user_id: current_user.id)
    favorite.destroy

    # @favorite = Favorite.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    # @favorite.destroy
    # redirect_back(fallback_location: root_path)
  end
end
