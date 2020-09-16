class StaticPagesController < ApplicationController
  def top
    @posts = Post.order(created_at: :desc).limit(36)
  end
end
