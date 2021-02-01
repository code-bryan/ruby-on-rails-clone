module Template
  module TemplateMethods
    def partial(name)
      Template::Renderer.new.partial(name, binding)
    end

    # @param key String
    # @return String
    def env(key)
      ENV[key]
    end
  end

  class LayoutRenderer
    include TemplateMethods

    def assets(name)
      return "/javascript/#{name}" if !name.match('js').nil?
      return "/assets/css/#{name}" if !name.match('css').nil?
      "/assets/#{name}"
    end 
  end

  class PartialRenderer < ERB
    include TemplateMethods
  end
end