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

    # @param layout string
    # @return LayoutRenderer
    def layout(layout = "layout/application")
      layout = File.read(File.join(App.root, 'app', 'views', "#{layout}.html.erb"))
      render = ERB.new(layout).def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    # @return ERB
    def self.template_engine
      ERB
    end
  end
end