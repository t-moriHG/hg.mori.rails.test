class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
    logger.debug("SessionsController.new called!")
  end

  def create
    logger.debug("SessionsController.create called!")
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to account_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    logger.debug("SessionsController.destroy called!")
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      logger.debug("SessionsController.set_user called!")
      @user = User.find_by!(name: session_params[:name])
    rescue
      flash.now[:danger] = t('.flash.invalid_name')
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      logger.debug("SessionsController.session_params called!")
      params.require(:session).permit(:name, :password)
    end

end