class Users::RegistrationsController < Devise::RegistrationsController
  before_action :forbid_test_user, { :only => [:edit,:update,:destroy] }

  private
  
  def forbid_test_user
    if @user.email == "test@example.com"
      flash[:notice] = "ゲストユーザーのため変更できません"
      redirect_to("/posts/index")
    end
  end
end
