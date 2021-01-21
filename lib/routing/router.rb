module Routing
  class Router
    include Controllers
    attr_reader :routes
    
    # @param routes String
    def initialize(routes)
      @routes = routes
    end
    
    # @param env Rake:Env
    def resolve(env)
      path = env['REQUEST_PATH']
      method = env['REQUEST_METHOD']

      if route = route_finder(path, method)
        controller_finder(route[:controller]).call
      else
        Controller.new.not_found
      end
    rescue Exception => error
      puts error.message
      puts error.backtrace
      Controller.new.internal_error
    end
    
    
    private 
    # @param path string
    # @return Controllers::Controller
    def controller_finder(path)
      controller_name, action_name = path.split('#')
      klass = Object.const_get "#{controller_name.capitalize}Controller"
      klass.new(name: controller_name, action: action_name.to_sym)
    end

    # @param path string
    # @param method string
    # @return Hash|Nil
    def route_finder(path, method)
      route = @routes.select { |route| route[:path] == path && route[:method] == method.downcase.to_sym}
      route.first
    end
  end
end