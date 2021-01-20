require_relative 'database'
require_relative 'loader'

# Creating database context
database = Database.new
DB = database.call

# Loading data
Loader.init

# Loading migrations
database.migrations

# loading framework
module Framework
  include Routing

  @routes = Routes.new

  def self.routes
    @routes
  end
end

# loading routes
Loader.init_routes

# Reading routings
ROUTES = Framework.routes.list