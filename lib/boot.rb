# Creating database context
db_config_file = File.join(File.dirname(__FILE__), '..', 'app', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  
  if config["adapter"]
    config["database"] = File.join(File.dirname(__FILE__), '..', 'database', config["database"])
  end

  DB = Sequel.connect(config)
  Sequel.extension :migration
end

# Connecting all our framework's classes
Dir[File.join(File.dirname(__FILE__), '..', 'lib', '*.rb')].each do |file|
  require file if !file.include? "boot.rb"
end

# loading models
Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '*.rb')].each do |file|
  require file
end

# loading controllers
Dir[File.join(File.dirname(__FILE__), '..', 'app', 'controllers', '*.rb')].each do|file|
  require file 
end

# If there is a database connection, running all the migrations
if DB
  Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'database', 'migrations'))
end


# Reading routings
ROUTES = YAML.load(File.read(File.join(File.dirname(__FILE__), '..', 'app', 'routes.yml')))