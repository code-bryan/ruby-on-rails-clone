
module Template
  
  class Renderer

    def initialize
      @route = "#{App.root}/resources/views"
    end

    def partial(name, bind = Context.get_context)
      view = File.read(File.join(@route, "#{resolve_name(name)}.html.erb"))
      PartialRenderer.new(view).result(bind)
    end

    def layout(name)
      layout = File.read(File.join(@route, "#{resolve_name(name)}.html.erb"))
      ERB.new(layout).def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    private
    attr_reader :route, :context

    def resolve_name(name)
      name = name.split('.').join('/')
    end
  end
end