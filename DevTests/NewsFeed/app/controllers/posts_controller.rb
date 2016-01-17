class PostsController < ApplicationController
  # GET /users/1/posts
  def index
    @posts = Post.all
    render json: @posts
  end
end
