class TweetsController < ApplicationController

    def top
    end

    def index
        @tweets = Tweet.all
        @q = Tweet.ransack(params[:q])
        @tweets = @q.result
        # @tweets = @q.result(distinct: true)
    end

    def search
        @q = Tweet.search(search_params)
        @tweets = @q.result
        # @tweets = @q.result(destinct: true)

    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.user_id = current_user.id
        binding.pry
        if @tweet.save
            flash[:notice] = "successfully created tweet!"
            redirect_to tweet_path(@tweet)
        else
            render 'new'
        end
    end

    def show
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
    def search_params
        params.require(:q).permit({:genre_ids => []})
    end

    def tweet_params 
        params.require(:tweet).permit(:title, :body, :image, {:genre_ids => []})
        #genre_ids: [] チェックボックスによって複数渡される場合があるのため配列形式
    end
end
