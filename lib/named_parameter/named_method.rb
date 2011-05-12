class NamedMethod
  attr_accessor :method

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
    errors += Errors::UndefinedParameters.all_when self, 
                                                  :called_with => args
    errors += Errors::RequiredParameters.all_when self, 
                                                  :called_with => args
    errors
  end

  def required_parameters
    @method.parameters.collect do |parameter| 
      parameter.last if parameter.first == :req
    end.compact
  end

  def have_a_parameter_like?(arg_name)
    @method.parameters.any? do |method_parameter|
      method_parameter[1].to_s == arg_name.to_s
    end
  end
end
