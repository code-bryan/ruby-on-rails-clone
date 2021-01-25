module Routing
  class BaseController
    include Http

    attr_accessor :status, :headers, :content
    
    # @param name String|Nil
    # @param action Symbol|Nil
    def initialize(name: nil, action: nil)
      @name = name
      @action = action
    end
    
    # @param request Http::Request
    # @param route_params Hash
    # @return Routing::BaseController
    def call(request, route_params)
      puts route_params
      response = route_params.nil? ? send(action, request) : send(action, request, *route_params.values)
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

    # @param name String
    # @return Erb
    def view(name = "#{self.name}.#{self.action}")
      Response.new(:view, name)
    end

    # @param data Hash
    def json(data = {})
      Response.new(:json, data)
    end

    # @param key String
    # @return String
    def environment(key)
      ENV[key]
    end
  
    private
    attr_reader :name, :action

    # @param status Routing::StatusCode
    # @param content string|render
    # @param headers Hash
    # @return Routing::BaseController
    def resolve(status = 200, content = "", headers = {"Content-Type" => "text/html"})
      self.status = status
      self.headers = headers
      self.content = [content]
      self
    end
  end
end