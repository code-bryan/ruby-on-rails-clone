class Loader
  attr_reader :instance

  def init
    load_require
    load_environment
  end

  def self.instance
    return @instance if @instance
    @instance = Loader.new
  end

  def init_models
    require File.join(File.dirname(__FILE__), '..', 'lib', 'database', 'model.rb')

    # loading models
    Dir[File.join(File.dirname(__FILE__), '..', 'app', 'models', '**', '*.rb')].each do |file|
        require file
    end
  end

  def init_routes 
    # loading routes 
    Dir[File.join(File.dirname(__FILE__), '..', 'routes', '*.rb')].each do |file|
        require file
    end
  end

  private

  def load_require
    # Connecting all our framework's classes
    Dir[File.join(File.dirname(__FILE__), '..', 'lib', '**', '*.rb')].each do |file|
      if ["boot.rb", "model.rb"].detect { |word| file.include? word }.nil?
        require file 
      end
    end
    
    # loading controllers
    Dir[File.join(File.dirname(__FILE__), '..', 'app', 'controllers', '**', '*.rb')].each do|file|
        require file 
    end

    Dir[File.join(File.dirname(__FILE__), '..', 'database', 'seeders', '**', '*.rb')].each do|file|
        require file 
    end
  end

  def load_environment
    ENV['RACK_ENV'] = ENV['APP_ENV']
  end
end