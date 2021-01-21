require_relative 'loader'
require_relative './database'
require "dotenv"

# Creating database context
database = Database.new
DB = database.call

# Loading data
Dotenv.load
loader = Loader.new
loader.init

# Loading migrations
database.migrations

loader.init_models

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
loader.init_routes

# Reading routings
ROUTES = Framework.route.list