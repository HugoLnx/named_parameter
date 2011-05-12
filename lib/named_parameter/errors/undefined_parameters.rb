module Errors
  class UndefinedParameters
    class << self
      def all_when(named_method,options)
        args = options[:called_with]
        args.collect do |arg|
          unless match?(named_method, arg)
            error = Error.new(named_method, arg.first, caller)
            UndefinedParameters.new(error)
          end
        end.compact
      end

    private
      def match?(named_method,arg)
        arg_name = arg.first
        named_method.have_a_parameter_like? arg_name
      end
    end

    def initialize(error)
      @error = error
    end

    def raise_args
      [error_message,@error.backtrace]
    end

  private
    def error_message
      "no parameter named '#{@error.argument_name}' for '#{@error.named_method.method.name}' method"
    end
  end
end
