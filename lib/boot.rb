require_relative 'database'
require_relative 'loader'

# Creating database context
database = Database.new
DB = database.call

Loader.init
database.migrations

module Framework
  @routes = Routing::Routes.new

  def self.routes
    @routes
  end
end

Loader.init_routes

# Reading routings
ROUTES = Framework.routes.list