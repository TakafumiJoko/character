class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "ログインに成功しました。"
      redirect_to user #のちに/postimages/indexに変更します。
    else
      flash.now[:danger] = "正しい入力をお願いします。"
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to signup_url 
  end
end
