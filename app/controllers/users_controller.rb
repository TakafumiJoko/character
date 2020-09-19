class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "登録に成功しました。"
      redirect_to new_post_url
    else
      render :new 
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
    
    def correct_user
      user = User.find_by(id: params[:id])
      unless user == current_user
        flash[:danger] = "権限がありません。"
        redirect_to new_post_url
      end
    end
end
