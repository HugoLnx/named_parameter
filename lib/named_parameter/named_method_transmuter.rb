module NamedParameter
  class NamedMethodTransmuter
    def self.transmute(method)
      named_method = NamedMethod.new(method)

      method.owner.instance_eval do
        define_method (method.name) do |options={}|
          errors = named_method.errors_when_called_with options
          raise ArgumentError,*errors.first.raise_args unless errors.empty?

          adapter = NamedParameter::ParametersAdapter.new(method)
          original_parameters = adapter.hash_to_args(options)

          original_named_method = method(named_method.name_of_original)
          original_named_method.call(*original_parameters.compact)
        end
      end
    end
  end
end
