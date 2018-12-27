class SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  def new
  end

  def create
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to root_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      @user = User.find_by!(name: session_params[:name])
    rescue
      flash.now[:danger] = t('.flash.invalid_name')
      render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      params.require(:session).permit(:name, :password)
    end

end