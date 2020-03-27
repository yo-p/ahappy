class TweetsController < ApplicationController

    def top
    end

    def index #tweetの一覧画面
        @tweets = Tweet.all
        # @q = Tweet.ransack(params[:q])
        # @tweets = @q.result(distinct: true)
    end

    def search #検索結果を表示
        # @q = Tweet.search(search_params)
        # @tweets = @q.result(distinct: true)

    end

    def new #tweetの新規投稿画面
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        if @tweet.save
            flash[:notice] = "successfully created tweet!"
            redirect_to tweet_path(@tweet)
        else
            render 'new'
        end
    end

    def show #tweetの詳細画面
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
        @favorite = Favorite.new
    end

    def destroy
        @tweet = Tweet.find(params[:id])
        @tweet.destroy
        flash[:notice] = "successfully delete tweet!"
        redirect_to user_path(current_user)
    end
    
private
    # def search_params
    #     params.require(:q).permit({:genre_id_in => []})
        # params.require(:q).permit({:genre_ids_in => []})
    # end

    def tweet_params 
        params.require(:tweet).permit(:title, :body, :image, {:genre_ids => []})
        #genre_ids: [] チェックボックスによって複数渡される場合があるのため配列形式
    end
end
