class PostsController < Routing::BaseController
  # @param Http::Request
  # @return Http::Response
  def index(request)
    @posts = Post.all
    view("view.test")
  end
end