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
    end
    
    # @return Routing::BaseController
    def call
      response = send(action)
      response = view if !response.instance_of? Response
      content, headers = response.resolve(binding)
      resolve(StatusCode::OK, content, headers)
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
      Response.new(:view, name)
    end

    # @param data Hash
    def json(data = {})
      Response.new(:json, data)
    end

    # @param key string
    # @return string
    def environment(key)
      ENV[key]
    end
  
    private

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