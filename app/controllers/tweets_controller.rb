class TweetsController < ApplicationController

    def top
    end

    def new
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

    def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments
        @comment = Comment.new
    end

    def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        flash[:notice] = "successfully delete tweet!"
        redirect_to user_path(current_user)
    end
    
private
    def tweet_params
        params.require(:tweet).permit(:title, :body, :genre, :image)
    end
end
