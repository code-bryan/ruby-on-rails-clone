require 'json/ext'

module Http
  class Request
    # @param env Hash
    def initialize(env)
      @env = env
      @rack_request = Rack::Request.new(@env)
    end
    
    # @return Hash 
    def params
      read_rack_input = @env['rack.input'].read
      # get if is a form data o get params request 
      return @rack_request.params if @rack_request.form_data? || read_rack_input.empty? 

      JSON.parse read_rack_input
    end

    private 
    attr_accessor :env, :rack_request
  end
end