class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack()
    if params[:q].present?
      @q = Post.ransack(search_params)
      @posts = @q.result
    else
      params[:q] = {sorts: 'id desc'}
      @posts = Post.all
    end
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
      render :new
    end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "編集に成功しました。"
      redirect_to @post
    else
      render :edit
    end
  end
  
  def destroy
    Post.destroy(params[:id])
    flash[:success] = "削除に成功しました。"
    redirect_to new_post_url
  end
  
  private
  
    def post_params
      params.require(:post).permit(:image_url,
                                   :origin, 
                                   :stroke_count)
    end

    def search_params
      params.require(:q).permit(:origin_cont, 
                                :sorts)
    end
    
    def correct_user
      post = Post.find_by(id:params[:id])
      unless post.user == current_user
        flash[:danger] = "権限がありません。"
        redirect_to post
      end
    end
end
