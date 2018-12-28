class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
    p "SessionsController.new called!"
  end

  def create
    p "SessionsController.create called!"
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      redirect_to account_path
    else
      flash.now[:danger] = t('.flash.invalid_password')
      render 'new'
    end
  end

  def destroy
    p "SessionsController.destroy called!"
    sign_out
    redirect_to login_path
  end

  private

    def set_user
      p "SessionsController.set_user called!"
      p "session_params[:name]:" + session_params[:name].to_s
      @user = User.find_by!(name: session_params[:name])
    #rescue
      #flash.now[:danger] = t('.flash.invalid_name')
      #p "++++++++++++++++++++++++++++++++++++++++++"
      #render action: 'new'
    end

    # 許可するパラメータ
    def session_params
      p "SessionsController.session_params start!"
      #p "params.require(:name, :password):" + params.require(:name, :password)
      #p "params.require(:session):" + params.require(:session).to_s
      params.require(:session).permit(:name, :password)
      p "SessionsController.session_params end!"
    end

end