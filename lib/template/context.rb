module Template
  class Context
    def self.generate(context)
      @context = context
    end

    def self.get_context
      @context
    end
  end
end