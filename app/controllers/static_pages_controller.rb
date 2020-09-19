class StaticPagesController < ApplicationController
  def top
    @posts = Post.limit(36)
  end
end
