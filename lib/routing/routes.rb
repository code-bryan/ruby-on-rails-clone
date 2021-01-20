module Routing
  class Routes
    attr_reader :list # a hash list
    
    def initialize
      @list = {}
    end

    # @param route string
    # @param controller string
    # @return nil
    def get(route, controller)
      @list[route] = controller
    end

    # @param route string
    # @param controller string
    # @return nil
    def post(route, controller)
      @list[route] = controller
    end

    # @param route string
    # @param controller string
    # @return nil
    def put(route, controller)
      @list[route] = controller
    end

    # @param route string
    # @param controller string
    # @return nil
    def delete(route, controller)
      @list[route] = controller
    end

    private

    # @param route string
    # @param type symbol
    # @return string
    def key_generator(route, type)
        "#{type.to_s}##{route}"
    end
  end
end