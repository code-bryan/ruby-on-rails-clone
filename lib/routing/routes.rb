module Routing
    class Routes
        attr_reader :list
    
        def initialize
            @list = {}
        end
    
        def get(route, controller)
            @list[route] = controller
        end
    end
end