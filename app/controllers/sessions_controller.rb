class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
  end

  def create
    user = User.create_if_empty(params[:name], params[:password])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_url
    else
      redirect_to login_url, notice: 'Invalid username/password combination!'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
