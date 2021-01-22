module Http
  class Response
    
    # @param name string
    # @return Erb
    def view(name = "#{self.name}/#{self.action}")
      file = File.read(File.join(App.root, 'app', 'views', "#{name}.html.erb"))
      ERB.new(file)
    end

    def self.template_engine
      ERB
    end
  end
end