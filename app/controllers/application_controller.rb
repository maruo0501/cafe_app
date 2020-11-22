class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :if => :devise_controller?
  before_action :set_current_user

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:account_update, :keys => [:name, :picture]) # アカウント編集時(account_update時)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_in, :keys => [:name])
  end

  def set_current_user
    @current_user = User.find_by(:id => session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("users/sign_in")
    end
  end
end
