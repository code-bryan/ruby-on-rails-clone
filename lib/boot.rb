require_relative 'loader'
require "dotenv"
require_relative './foundations/database'

# Creating database context
database = Foundations::Database.new
DB = database.call

# Loading data
Dotenv.load
Loader.instance.init

# Loading migrations
database.migrations

Loader.instance.init_models

# Loading seeder
database.seeder

# loading framework
module Framework
  include Routing

  @route = Route.new

  def self.route
    @route
  end
end


# loading routes
Loader.instance.init_routes

# Reading routings
ROUTES = Framework.route.list