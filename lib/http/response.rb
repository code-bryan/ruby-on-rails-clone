require 'json/ext'
module Http
  class LayoutRenderer
  end

  class Response

    # @param type Symbol
    # @param content Hash|String
    def initialize(type, content)
      @type = type
      @content = content
    end

    def resolve(bind)
      return json(@content) if @type == :json

      view(@content, bind)
    end
    
    # @param name string
    # @return [Erb, Hash]
    def view(name = "#{self.name}.#{self.action}", bind)
      content = layout.render do
        name = name.split('.').join('/')
        view = File.read(File.join(App.root, 'resources', 'views', "#{name}.html.erb"))
        ERB.new(view).result(bind)
      end
      [content, {"Content-Type" => "text/html"}]
    end

    # @param json [Hash, Hash]
    def json(data = {})
      [data.to_json, {"Content-Type" => "application/json"}]
    end

    # @param layout string
    # @return LayoutRenderer
    def layout(layout = "layout/application")
      layout = File.read(File.join(App.root, 'resources', 'views', "#{layout}.html.erb"))
      render = ERB.new(layout).def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    # @return ERB
    def self.template_engine
      ERB
    end

    private
    attr_accessor :type, :content
  end
end