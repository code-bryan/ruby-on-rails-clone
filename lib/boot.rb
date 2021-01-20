require_relative 'database'
require_relative 'loader'

# Creating database context
DB = Database.new.call
Loader.init

module Framework
  @routes = Routes.new

  def self.routes
    @routes
  end
end

Loader.init_routes

# Reading routings
ROUTES = Framework.routes.list