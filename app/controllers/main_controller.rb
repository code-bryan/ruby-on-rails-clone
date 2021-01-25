class MainController < Routing::BaseController
  # @param Http::Request
  # @return Http::Response
  def index(request, name, hola)
    puts name
    puts hola
    @test = environment("APP_NAME")
    @arr = %w(one two three)
    view("main.index")
  end

  # @param Http::Request
  # @return Http::Response
  def create(request)
    json(request.params)
  end
end