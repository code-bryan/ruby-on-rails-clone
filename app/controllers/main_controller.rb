class MainController < Controllers::Controller
  def index
    @test = "#{environment("APP_NAME")}"
    @arr = %w(one two three)
  end

  def create; end
end