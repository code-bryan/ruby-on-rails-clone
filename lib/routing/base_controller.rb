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
      @response = Response.new
    end
    
    # @return Routing::BaseController
    def call
      content = send(action)
      content = view if !content.instance_of? Response.template_engine
      resolve(StatusCode::OK, content)
    end
    
    # @return Routing::BaseController
    def not_found
      resolve(StatusCode::NOT_FOUND, "Not Found", {})
    end
    
    # @return Routing::BaseController
    def internal_error
      resolve(StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error", {})
    end

    protected

    # @param name string
    # @return Erb
    def view(name = "#{self.name}/#{self.action}")
      @response.layout.render do
        @response.view(name).result(binding)
      end
    end

    # @param key string
    # @return string
    def environment(key)
      ENV[key]
    end
  
    private
    attr_reader :response

    # @param status Routing::StatusCode
    # @param content string|render
    # @param headers hash
    # @return Routing::BaseController
    def resolve(status = 200, content = "", headers = {"Content-Type" => "text/html"})
      self.status = status
      self.headers = headers
      self.content = [content]
      self
    end
  end
end