require 'spec_helper'

module NamedParameter
  describe ParametersAdapter do
    context "two optional parameters" do
      it 'maintain the default value in the middle too' do
        def test_method(arg1 = "default1", arg2 = "default2");end

        method = method(:test_method)
        adapter = ParametersAdapter.new(method)
        arguments = adapter.hash_to_args({arg2: "argument2"})

        arguments.should == ["default1", "argument2"]
      end
    end

    context "one parameter with default value as a lambda" do
      it 'maintain the default value in the middle too' do
        def test_method(a,b="z",c=lambda{|arg1,arg2| arg1 + "test"},d="z");end

        method = method(:test_method)
        adapter = ParametersAdapter.new(method)
        arguments = adapter.hash_to_args({a: "a", d: "d"})

        arguments[0].should == "a"
        arguments[1].should == "z"
        arguments[2].should be_a Proc
        arguments[3].should == "d"
      end
    end
  end
end
