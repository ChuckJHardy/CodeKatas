class PostsController < ApplicationController
  # GET /posts
  def index
    @posts = Post.includes(:user).page(page).per(per_page)
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
