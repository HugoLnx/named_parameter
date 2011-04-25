class NamedMethod
  module Validators
    module UndefinedParametersValidator
      def required_parameter_errors_in(method,args)
        required_parameters.collect do |parameter_name|
          unless args.has_key?(parameter_name) || args.has_key?(parameter_name.to_sym)
            raise_args_for_required_parameter_error(parameter_name,method.name)
          end
        end.compact
      end

      def required_parameters
        @method.parameters.collect do |parameter| 
          parameter.last if parameter.first == :req
        end.compact
      end

      def raise_args_for_required_parameter_error(parameter_name,method_name)
        backtrace = clean_backtrace
        error_msg = required_parameter_error_message_for(parameter_name,method_name)
        [error_msg,backtrace]
      end

      def required_parameter_error_message_for(parameter_name,method_name)
        "undeclared parameter named '#{parameter_name}' for #{method_name} method"
      end
    end

    module RequiredParametersValidator

      def undefined_parameter_errors_in(method, args)
        args.collect do |arg|
          arg_name = arg.first
          unless have_a_parameter_like? arg_name
            raise_args_for_undefined_parameter_error(arg_name,method.name)
          end
        end.compact
      end

      def have_a_parameter_like?(arg_name)
        @method.parameters.any? do |method_parameter|
          method_parameter[1].to_s == arg_name.to_s
        end
      end

      def raise_args_for_undefined_parameter_error(invalid_arg_name,method_name)
        backtrace = clean_backtrace
        error_msg = undefined_parameters_error_message_for(invalid_arg_name,method_name)
        [error_msg,backtrace]
      end

      def undefined_parameters_error_message_for(invalid_arg_name,method_name)
        "no parameter named '#{invalid_arg_name}' for '#{method_name}' method"
      end
    end
  end

  def self.private_include(mod)
    include mod
    private *mod.instance_methods
  end

  private_include Validators::UndefinedParametersValidator
  private_include Validators::RequiredParametersValidator

  def initialize(method)
		method.owner.instance_eval do
			alias_method :"___original_#{method.name}___",method.name.to_sym
		end
    @method = method
  end

	def name_of_original
		:"___original_#{@method.name}___"
	end

  def errors_when_called_with(args={})
    errors = []
    errors += undefined_parameter_errors_in(@method,args)
    errors += required_parameter_errors_in(@method,args)
    errors
  end

private

  def clean_backtrace
    backtrace = caller
    2.times{backtrace.delete_at(0)}
    backtrace
  end
end
