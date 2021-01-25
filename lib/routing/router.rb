module Routing
  class Router
    include Http

    attr_reader :routes
    
    # @param routes String
    def initialize(routes)
      @routes = routes
    end
    
    # @param env Hash
    # @return Routing::BaseController
    def resolve(env)
      path, method = [env['REQUEST_PATH'], env['REQUEST_METHOD']]

      route, params = route_finder(path, method)
      return BaseController.new.not_found if route.nil?

      controller = route[:controller]
      request = Request.new(env)
      return call_proc(controller, request, params) if controller.is_a? Proc

      controller_finder(controller).call(request, params)
    rescue Exception => error
      puts error.message
      puts error.backtrace
      BaseController.new.internal_error
    end
    
    
    private 

    def call_proc(controller, request, params)
      return controller.call(request, *params.values) if !params.nil?
      controller.call(request)  
    end

    # @param path String
    # @return Routing::BaseController
    def controller_finder(path)
      controller_name, action_name = path.split('#')
      klass = Object.const_get "#{controller_name.capitalize}Controller"
      klass.new(name: controller_name, action: action_name.to_sym)
    end

    # @param path String
    # @param method String
    # @return [Hash|Nil, Hash|Nil]
    def route_finder(path, method)
      params = nil
      route = @routes.detect do |route|
        route_path = route[:path]
        route_path, params = detect_request_params(path, route) if !route[:params].nil?
        params = nil if route[:params].nil?
        route_path == path && route[:method] == method.downcase.to_sym 
      end
      
      [route, params]
    end

    # @param path String
    # @param method String
    # @return [Hash|Nil, Hash|Nil]
    def detect_request_params(path, route)
      path_params = path.split('/').select { |pa| !pa.empty? }
      route_params = route[:path].split('/').select { |pa| !pa.empty? }

      params = Hash.new
      route_params.map.with_index { |key, index|
        key_fixed = key.split(":").last.to_sym
        params[key_fixed] = path_params[index] if key.match(":")
      }


      new_path = route[:path].dup
      params.keys.map { |key| new_path.sub!(":#{key}", params[key].to_s) }
      
      [new_path, params]
    end
  end
end