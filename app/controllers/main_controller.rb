class MainController < Routing::BaseController
  def index
    @test = environment("APP_NAME")
    @arr = %w(one two three)
    json({ test: @test, arr: @a })
  end

  def create; end
end