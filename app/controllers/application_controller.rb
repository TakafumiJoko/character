class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "セッション情報が切れています。"
      redirect_to login_url 
    end
  end
  
end
