class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.paginate(page: params[:page])
  end
  
  def show
    @post = Post.find_by(id: params[:id])
    @comment = current_user.comments.build
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿に成功しました。"
      redirect_to @post
    else
      render :show
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "編集に成功しました。"
      redirect_to edit_post_url
    else
      render :edit
    end
  end
  
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = "削除に成功しました。"
    redirect_to new_post_url
  end
  
  private
  
    def post_params
      params.require(:post).permit(:image_url,
                                   :origin, 
                                   :stroke_count)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      if @post.nil?
        flash[:danger] = "権限がありません。"
        redirect_to new_post_url
      end
    end
end
