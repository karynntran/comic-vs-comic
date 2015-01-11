class UsersController < ApplicationController
  before_filter :authorize, except: [:show, :new, :create]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    if params[:user]
      @user = User.create(user_params)
      render 'home/index'
    else
      @user = User.create(username: params[:username], password: params[:password])
      render 'home/index'
    end
  end

  def destroy
    @user.destroy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :image, :first_name, :last_name, :powers)
  end

end