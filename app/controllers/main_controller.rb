class MainController < Routing::BaseController
  # @param Http::Request
  # @return Http::Response
  def index(request)
    @test = env("APP_NAME")
    @arr = %w(one two three)
    view("main.index")
  end

  # @param Http::Request
  # @param name String
  # @param hola String
  # @return Http::Response
  def hola(request, name, hola, prueba)
    @test = env("APP_NAME")
    @arr = [name, hola, prueba]
    view("main.index")
  end


  # @param Http::Request
  # @return Http::Response
  def create(request)
    json(request.params)
  end
end