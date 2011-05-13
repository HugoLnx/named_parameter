module NamedParameter::Errors
  class RequiredParameters
    def self.all_when(named_method,options)
      args = options[:called_with]
      named_method.required_parameters.collect do |parameter_name|
        unless args.has_key?(parameter_name) || args.has_key?(parameter_name.to_sym)
          error = NamedParameter::Error.new(named_method,parameter_name,caller)
          RequiredParameters.new(error)
        end
      end.compact
    end

    def initialize(error)
      @error = error
    end

    def raise_args
      [error_message,@error.backtrace]
    end

  private
    def error_message
    "undeclared parameter named '#{@error.argument_name}' for '#{@error.named_method.method.name}' method"
    end
  end
end
