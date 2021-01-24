module Routing
  class Route
    attr_reader :list # a array list
    
    def initialize
      @list = []
    end

    # @param route String
    # @param controller String
    # @return Nil
    def get(route, controller)
      route_generator(route, :get, controller)
    end

    # @param route String
    # @param controller String
    # @return Nil
    def post(route, controller)
      route_generator(route, :post, controller)
    end

    # @param route String
    # @param controller String
    # @return Nil
    def put(route, controller)
      route_generator(route, :put, controller)
    end

    # @param route String
    # @param controller String
    # @return Nil
    def path(route, controller)
      route_generator(route, :path, controller)
    end

    # @param route String
    # @param controller String
    # @return Nil
    def delete(route, controller)
      route_generator(route, :delete, controller)
    end

    private

    # @param route String
    # @param method Symbol
    # @param controller String
    # @return Nil
    def route_generator(route, method, controller)
      @list.push({path: route, method: method, controller: controller})
    end
  end
end