module Routing
  class BaseController
    include Http

    attr_reader :name, :action
    attr_accessor :status, :headers, :content
    
    # @param name string
    # @param actuon symbol
    def initialize(name: nil, action: nil)
      @name = name
      @action = action
      @@response = Response.new
    end
    
    # @return Routing::BaseController
    def call
      action_send = send(action)
      content = view
      content = action_send if action_send.instance_of? @template.template_instance
      resolve(StatusCode::OK, content.render(self))
    end
    
    # @return Routing::BaseController
    def not_found
      resolve(StatusCode::NOT_FOUND, "Not Found", {})
    end
    
    # @return Routing::BaseController
    def internal_error
      resolve(StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error", {})
    end
  
    # @param name string
    # @return Http::Response
    def view(name = "#{self.name}/#{self.action}")
      @response.view(name)
    end

    protected

    # @param key string
    # @return string
    def environment(key)
      ENV[key]
    end
  
    private
    attr_reader :template

    # constanrts
    DEFAULT_CONTENT_TYPE = {"Content-Type" => "text/html"}

    # @param status Routing::StatusCode
    # @param content string|render
    # @param headers hash
    # @return Routing::BaseController
    def resolve(status = 200, content = "", headers = DEFAULT_CONTENT_TYPE)
      self.status = status
      self.headers = headers
      self.content = [content]
      self
    end
  end
end