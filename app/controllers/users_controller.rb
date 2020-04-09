# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user.id != current_user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'プロフィールを変更しました！！'
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
