module Routing
    class Routes
        attr_reader :list
    
        def initialize
            @list = {}
        end
    
        def get(route, controller)
            @list[route] = controller
        end

        def post(route, controller)
            @list[route] = controller
        end

        def put(route, controller)
            @list[route] = controller
        end

        def delete(route, controller)
            @list[route] = controller
        end
    end
end