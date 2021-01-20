module Routing
  class Router
    include Controllers
    attr_reader :routes
    
    # @param routes Hash
    def initialize(routes)
      @routes = routes
    end
    
    # @param env Rake:Env
    def resolve(env)
      path = env['REQUEST_PATH']
      if routes.key?(path)
        controller_finder(routes[path]).call
      else
        Controller.new.not_found
      end
    rescue Exception => error
      puts error.message
      puts error.backtrace
      Controller.new.internal_error
    end
    
    # @param path string
    private def controller_finder(path)
      controller_name, action_name = path.split('#')
      klass = Object.const_get "#{controller_name.capitalize}Controller"
      klass.new(name: controller_name, action: action_name.to_sym)
    end
  end
end