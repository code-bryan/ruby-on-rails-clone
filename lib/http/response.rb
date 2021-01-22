module Http
  class LayoutRenderer
  end

  class Response
    
    # @param name string
    # @return Erb
    def view(name = "#{self.name}/#{self.action}")
      view = File.read(File.join(App.root, 'app', 'views', "#{name}.html.erb"))
      ERB.new(view)
    end

    # @return LayoutRenderer
    def layout
      layout = File.read(File.join(App.root, 'app', 'views', 'layout', "application.html.erb"))
      render = ERB.new(layout)
      render.def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    def self.template_engine
      ERB
    end
  end
end