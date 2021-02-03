class UsersController < ApplicationController
  def new
    @user = User.create
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    flash[:success] = "Welcome, #{new_user.email}"
    redirect_to root_path
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user and user.authenticate(params[:password])
      # tim will add code here, be prepared!
      flash[:success] = "Welcome, #{user.email}"
      redirect_to root_path
    else
      flash[:error] = "I am pretty sure that isn't your account"
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
