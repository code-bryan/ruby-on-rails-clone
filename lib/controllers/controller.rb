module Controllers
  class Controller
    attr_reader :name, :action
    attr_accessor :status, :headers, :content
    
    # @param name string
    # @param actuon symbol
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
  
      self.status = 200
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
    # @return Render.template_instance 
    def render(name = "#{self.name}/#{self.action}")
      @template.call(name)
    end

    protected

    # @param key string
    # @return string
    def environment(key)
      ENV[key]
    end
  
    private
    attr_reader :template
  end
end