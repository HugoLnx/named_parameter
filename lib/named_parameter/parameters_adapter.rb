module NamedParameter
  class ParametersAdapter
    attr_reader :method

    def initialize(method)
      @method = method
    end

    def hash_to_args(options)
      original_parameters = []
      @method.parameters.each do |parameter|
        parameter_name = parameter.last
        original_parameters << options[parameter_name]
      end

      return original_parameters
    end
  end
end
