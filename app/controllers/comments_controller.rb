# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:destroy]

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:success] = '投稿に成功しました。'
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def destroy
    Comment.destroy(params[:id])
    flash[:success] = '削除に成功しました。'
    redirect_to post_url(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    comment = Comment.find_by(id: params[:id])
    unless comment.user == current_user
      flash[:danger] = '権限がありません。'
      redirect_to new_post_url
    end
  end
end
