module Controllers
    class Render
        attr_reader :template_instance
    
        def initialize
            @template_instance = Slim::Template
        end
    
        def call(name = "#{self.name}/#{self.action}")
            @template_instance.new(File.join(App.root, 'app', 'views', "#{name}.slim"))
        end
    end
end