class PostsController < Routing::BaseController
  # @param Http::Request
  # @return Http::Response
  def index(request)
    @posts = Post.all
    view("view.test")
  end

  # @param request Http::Request
  # @param id String
  # @return Http::Response
  def show(request, id)
    @post = Post.where(id: id).first
  end
end