class PostsController < Routing::BaseController
  def index
    @posts = Post.all
    view("view.test")
  end
end