class MainController < Controller
  def index
    @test = "dump data"
    @arr = %w(one two three)
  end
end