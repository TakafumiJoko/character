class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "ログインに成功しました。"
      redirect_to new_post_url
    else
      flash.now[:danger] = "正しい入力をお願いします。"
      render :new
    end
  end
  
  def destroy
    log_out
    flash[:success] = "ログアウトに成功しました。"
    redirect_to login_url 
  end
  
  def create_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = SecureRandom.urlsafe_base64
    end
    log_in user
    redirect_to new_post_url, notice: 'ゲストユーザーとしてログインしました。'
  end
end
