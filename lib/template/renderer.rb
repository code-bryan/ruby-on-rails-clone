
module Template
  
  class Renderer
    def partial(name, bind)
      view = File.read(File.join(App.root, 'resources', 'views', "#{resolve_name(name)}.html.erb"))
      PartialRenderer.new(view).result(bind)
    end

    def layout(name)
      layout = File.read(File.join(App.root, 'resources', 'views', "#{resolve_name(name)}.html.erb"))
      render = ERB.new(layout)
      render.def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    private

    def resolve_name(name)
      name = name.split('.').join('/')
    end
  end
end