class SessionsController < ApplicationController

  #temporarily handling errors"
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
    @user = User.new
  end

  def create
      user = User.find_by({username: params[:user][:username]})
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        session[:user_id] = nil
        redirect_to root_path
      end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end