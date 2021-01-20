class Database
    def initialize
        config_file = File.join(File.dirname(__FILE__), '..', 'config', 'database.yml')
        @config = File.exist?(config_file) ? YAML.load(File.read(config_file)) : nil
    end

    def file_sqlite_loader
        @config["database"] = File.join(File.dirname(__FILE__), '..', 'database', @config["database"])
    end

    def call
        file_sqlite_loader if @config["adapter"] = "sqlite"
        @database = Sequel.connect(@config)
        Sequel.extension :migration
        return @database
    end

    def migrations
        if @database
            Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), '..', 'database', 'migrations'))
        end
    end

    private
    attr_reader :config, :database
end