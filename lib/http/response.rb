require 'json/ext'
module Http
  class LayoutRenderer
  end

  class Response
    attr_accessor :status, :headers, :content
    # @param type Symbol
    # @param content Hash|String
    def initialize(type, data)
      @type = type
      @data = data
    end

    def resolve(bind)
      return json(@data) if @type == :json

      view(@data, bind)
    end
    
    # @param name string
    # @return [Erb, Hash]
    def view(name = "#{self.name}.#{self.action}", bind)
      content = layout.render do
        name = name.split('.').join('/')
        view = File.read(File.join(App.root, 'resources', 'views', "#{name}.html.erb"))
        ERB.new(view).result(bind)
      end
      resolve_with_okay_status(content, {"Content-Type" => "text/html"})
    end

    # @param json [Hash, Hash]
    def json(data = {})
      resolve_with_okay_status(data.to_json, {"Content-Type" => "application/json"})  
    end

    # @param layout string
    # @return LayoutRenderer
    def layout(layout = "layout/application")
      layout = File.read(File.join(App.root, 'resources', 'views', "#{layout}.html.erb"))
      render = ERB.new(layout).def_method(LayoutRenderer, 'render')
      LayoutRenderer.new
    end

    def not_found
      resolve_route(Routing::StatusCode::NOT_FOUND, "Not Found", {})
    end

    def internal_error
      resolve_route(Routing::StatusCode::INTERNAL_SERVER_ERROR, "Internal Server Error", {})
    end

    def self.error
      Response.new(nil, nil)
    end

    def self.view(name = "#{self.name}.#{self.action}", bind)
      Response.new(:view, name).resolve(bind)
    end

    def self.json(data = {})
      Response.new(:json, data).resolve(nil)
    end

    

    private
    attr_accessor :type, :data

    def resolve_with_okay_status(content, headers)
      resolve_route(Routing::StatusCode::OK, content, headers)
    end
    
    # @param status Routing::StatusCode
    # @param content string|render
    # @param headers Hash
    # @return Routing::BaseController
    def resolve_route(status = 200, content = "", headers = {"Content-Type" => "text/html"})
      self.status = status
      self.headers = headers
      self.content = [content]
      self
    end
  end
end