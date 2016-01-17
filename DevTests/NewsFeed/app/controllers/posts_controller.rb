class PostsController < ApplicationController
  # GET /users/1/posts
  def index
    @posts = Post.page(page).per(per_page)
    render json: @posts
  end

  private

  def page
    params.fetch(:page, 1)
  end

  def per_page
    params.fetch(:per_page, 10)
  end
end
