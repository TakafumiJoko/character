class StaticPagesController < ApplicationController
  def top
    @posts = Post.limit(27)
  end
end
