module Http
  class Response
    attr_reader :template_instance
    
    def initialize
      set_template_instance
    end
    
    def view(name = "#{self.name}/#{self.action}")
      @template_instance.new(File.join(App.root, 'app', 'views', "#{name}.slim"))
    end

    private

    def set_template_instance
      @template_instance = Slim::Template
    end
  end
end