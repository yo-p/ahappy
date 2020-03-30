class UsersController < ApplicationController
    before_action :authenticate_user!
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
        @tweets = @user.tweets
    end

    def edit
        @user = User.find(params[:id])
        if @user.id != current_user.id
            redirect_to user_path(current_user)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:notice] = "successfully updated user!"
            redirect_to user_path(@user)
        else
            render 'edit'
        end
    end



private
def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
end

end
