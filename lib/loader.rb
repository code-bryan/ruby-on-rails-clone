module Loader
    def self.init
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
    end

    def self.init_routes 
        # loading routes 
        Dir[File.join(File.dirname(__FILE__), '..', 'routes', '*.rb')].each do |file|
            require file
        end
    end
end