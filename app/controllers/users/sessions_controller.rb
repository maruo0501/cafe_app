class Users::SessionsController < Devise::SessionsController
  
  
  def new_guest
    user = User.find_or_create_by(:email => 'test@example.com') do |db_user|
      db_user.password = 123456
      db_user.name = "ゲストユーザー"
    end
    sign_in user
    redirect_to("/posts/index")
    flash[:notice] = "ゲストユーザーとしてログインしました"
  end
end
