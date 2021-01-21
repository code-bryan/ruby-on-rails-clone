module Routing
  class Routes
    attr_reader :list # a array list
    
    def initialize
      @list = []
    end

    # @param route string
    # @param controller string
    # @return nil
    def get(route, controller)
      route_generator(route, :get, controller)
    end

    # @param route string
    # @param controller string
    # @return nil
    def post(route, controller)
      route_generator(route, :post, controller)
    end

    # @param route string
    # @param controller string
    # @return nil
    def put(route, controller)
      route_generator(route, :put, controller)
    end

    # @param route string
    # @param controller string
    # @return nil
    def path(route, controller)
      route_generator(route, :path, controller)
    end

    # @param route string
    # @param controller string
    # @return nil
    def delete(route, controller)
      route_generator(route, :delete, controller)
    end

    private

    # @param route string
    # @param method symbol
    # @param controller string
    def route_generator(route, method, controller)
      @list.push({path: route, method: method, controller: controller})
    end
  end
end