class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    p "++++++" + @user.to_s
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

end