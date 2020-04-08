# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def top; end

  def index # tweetの一覧画面
    @tweets = Tweet.all.page(params[:page])
    @q = TweetGenre.ransack(params[:q])
    @tweet_genres = @q.result(distinct: true)
  end

  def search # 検索結果を表示
    ids = [] # 配列形式を指定
    @q = TweetGenre.search(search_params)
    @tweet_genres = @q.result(distinct: true)
    @tweet_genres.each do |genre|
      ids << genre.tweet_id # ids[tweet_genresのtweet_idが配列で選んだgenre_idの数だけ入る]
    end
    tweet_ids = ids.uniq # uniqで重複しているtweet_idを一意にしてtweet_idsに格納
    @tweets = Tweet.where(id: tweet_ids) # where(id: uniqで一意にしたtweet_id)
    @tweets = @tweets.page(params[:page])
  end

  def new # tweetの新規投稿画面
    @tweet = Tweet.new
  end

  def create # 保存機能
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    if @tweet.save
      flash[:notice] = '新規投稿しました'
      redirect_to tweet_path(@tweet)
    else
      render 'new'
    end
  end

  def show # tweetの詳細画面
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
    @favorite = Favorite.new
  end

  def destroy # 削除機能
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:notice] = '投稿を削除しました'
    redirect_to user_path(current_user)
  end

  private

  def search_params
    params.require(:q).permit({ genre_id_in: [] })
  end

  def tweet_params
    params.require(:tweet).permit(:title, :body, :image, { genre_ids: [] })
    # genre_ids: [] チェックボックスによって複数渡される場合があるのため配列形式
  end
end
