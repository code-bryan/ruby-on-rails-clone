class PostsController < Routing::BaseController
  def index
    @posts = Post.all
    view("test")
  end
end