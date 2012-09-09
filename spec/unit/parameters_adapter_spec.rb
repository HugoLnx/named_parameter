require 'spec_helper'

module NamedParameter
  describe ParametersAdapter do
    it 'maintain the default value in the middle too' do
      def metodo_teste(arg1 = "default1", arg2 = "default2");end

      method = method(:metodo_teste)
      adapter = ParametersAdapter.new(method)
      arguments = adapter.hash_to_args({arg2: "argument2"})

      arguments.should == ["default1", "argument2"]
    end
  end
end
