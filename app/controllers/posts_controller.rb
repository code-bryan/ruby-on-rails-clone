class PostsController < Controller
  def index
    @posts = Post.all
    render("test")
  end
end