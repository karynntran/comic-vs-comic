class UsersController < ApplicationController
  before_filter :authorize, except: [:show, :new, :create]

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    if params[:user]
      @user = User.create(user_params)
      render 'home/index'
    else
      @user = User.create(username: params[:username], password: params[:password])
      render 'home/index'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :image, :first_name, :last_name, :powers)
  end

end