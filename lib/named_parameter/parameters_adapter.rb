module NamedParameter
  class ParametersAdapter
    NO_ARGUMENT = Object.new

    attr_reader :method

    def initialize(method)
      @method = method
    end

    def hash_to_args(options)
      original_parameters = []
      @method.parameters.each_with_index do |parameter, i|
        parameter_name = parameter.last
        if options.has_key? parameter_name
          original_parameters << options[parameter_name]
        else
          original_parameters << NO_ARGUMENT
        end
      end

      arguments = fill_no_arguments(original_parameters)

      return arguments
    end

  private

    def fill_no_arguments(arguments)
      while arguments.last.equal? NO_ARGUMENT
        last_index = arguments.size - 1
        arguments.delete_at last_index
      end

      if arguments.any?{|arg| arg.equal? NO_ARGUMENT}
        extractor = DefaultsExtractor::DefaultParametersExtractor.new
        defaults = extractor.defaults_of(@method)
        
        arguments.map!.with_index do |arg, i|
          no_argument = arg.equal? NO_ARGUMENT
          no_argument ? defaults[i] : arg
        end
      end

      return arguments
    end
  end
end
