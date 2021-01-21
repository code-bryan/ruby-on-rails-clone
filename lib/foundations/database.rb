module Foundations
  class Database
    def initialize
      config_file = File.join(File.dirname(__FILE__), '../..', 'config', 'database.yml')
      @config = File.exist?(config_file) ? YAML.load(File.read(config_file)) : nil
    end
  
    def file_sqlite_loader
      @config["database"] = File.join(File.dirname(__FILE__), '../..', 'database', @config["database"])
    end
  
    def call
      file_sqlite_loader if @config["adapter"] = "sqlite"
      @database = Sequel.connect(@config)
      Sequel.extension :migration
      return @database
    end
  
    def migrations
      if @database
        Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '../..', 'database', 'migrations'))
      end
    end
  
    def seeder
      if @database
        Dir.entries(File.join(File.dirname(__FILE__), '../..', 'database', 'seeders')).each do |file|
          if file.include? ".rb"
            name = file.split("_").each { |word| word.capitalize! }.join("").split(".")[0]
            seeder_class = Object.const_get name
            seeder_class.new.call
          end
        end
      end
    end
  
    private
    attr_reader :config, :database
  end
end