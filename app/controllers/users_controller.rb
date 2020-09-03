class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
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
      flash[:success] = "新規登録に成功しました。"
      redirect_to @user #のちにpostImage/indexに変更します。
    else
      render :new 
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "更新に成功しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    log_out
    redirect_to signup_url #のちにトップページに変更します。
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "セッション情報が切れています。"
        redirect_to login_url 
      end
    end
end
