class PostsController < Routing::BaseController
  def index
    @posts = Post.all
    render("test")
  end
end