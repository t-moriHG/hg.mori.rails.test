class ApplicationController < ActionController::Base
  #before_action :basic
  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?
  
  protect_from_forgery with: :exception
  
  def current_user
    p "current_user called!"
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_in(user)
    p "sign_in called!"
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
    p "########" + @current_user.to_s
  end

  def sign_out
    p "sign_out called!"
    @current_user = nil
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    p "signed_in? called!"
    @current_user.present?
  end

  private
  def require_sign_in!
    p "require_sign_in! called!"
    redirect_to login_path unless signed_in?
  end
  
  def basic
    p "basic called!"
    authenticate_or_request_with_http_basic do |name, password|
      name == "test" && password == "123456"
    end
  end
  
end
