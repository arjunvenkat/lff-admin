class ApiPostsController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery :except => [:index, :show]
  def index
    @posts = Post.order(timestamp: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end
end
