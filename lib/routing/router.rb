module Routing
  class Router
    attr_reader :routes
    
    # @param routes String
    def initialize(routes)
      @routes = routes
    end
    
    # @param env Rack::Environment
    def resolve(env)
      path, method = [env['REQUEST_PATH'], env['REQUEST_METHOD']]

      if route = route_finder(path, method)
        controller_finder(route[:controller]).call
      else
        BaseController.new.not_found
      end
    rescue Exception => error
      puts error.message
      puts error.backtrace
      BaseController.new.internal_error
    end
    
    
    private 
    # @param path string
    # @return Routing::BaseController
    def controller_finder(path)
      controller_name, action_name = path.split('#')
      klass = Object.const_get "#{controller_name.capitalize}Controller"
      klass.new(name: controller_name, action: action_name.to_sym)
    end

    # @param path string
    # @param method string
    # @return Hash|Nil
    def route_finder(path, method)
      @routes.detect { |route| route[:path] == path && route[:method] == method.downcase.to_sym}
    end
  end
end