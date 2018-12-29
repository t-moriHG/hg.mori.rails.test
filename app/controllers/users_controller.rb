class UsersController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  def new
    logger.debug("UsersController.new called!")
    @user = User.new
  end

  def create
    logger.debug("UsersController.create called!")
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render 'new'
    end
  end

  private
    def user_params
      logger.debug("UsersController.user_params called!")
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

end