class Render
  attr_reader :template_instance

  def initialize
    @template_instance = Slim::Template
  end

  def call(name = "#{self.name}/#{self.action}")``
    @template_instance.new(File.join(App.root, 'app', 'views', "#{name}.slim"))
  end
end

class Controller
  attr_reader :name, :action, :data
  attr_accessor :status, :headers, :content

  def initialize(name: nil, action: nil)
    @name = name
    @action = action

    @template = Render.new
  end

  def call
    action_send = send(action)
    content = render

    if action_send.instance_of? @template.template_instance
      content = action_send
    end

    self.status = 200 # 3
    self.headers = {"Content-Type" => "text/html"}
    self.content = [content.render(self)]
    self
  end

  def not_found
    self.status = 404
    self.headers = {}
    self.content = ["Not found"]
    self
  end

  def internal_error
    self.status = 500
    self.headers = {}
    self.content = ["Internal error"]
    self
  end

  # @param name string
  def render(name = "#{self.name}/#{self.action}")
    @template.call(name)
  end

  private
  attr_reader :template
end