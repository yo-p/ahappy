# frozen_string_literal: true

class FavoritesController < ApplicationController
  def index
    # ログインしているuserのお気に入りを全件取得
    @favorites = Favorite.where(user_id: current_user.id).all
  end

  def create
    @favorite = Favorite.new(user_id: current_user.id, tweet_id: params[:tweet_id])
    @favorite.save
    #通知機能
    create_notice_favorite!(current_user)
    ######
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end
