class UsersController < ApplicationController
  before_action :require_login, only: :index

  # to illustrate a before_action
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #login user
      session[:user_id] = @user.id
      #redirect to user#show
      redirect_to @user
    else
      #there was an error, go back to signup page
      #TODO: pack errors into a flash message & pass to :new view 
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
