require 'spec_helper'

module NamedParameter
  describe NamedMethod do
    before :each do
      @method = stub(:method).as_null_object
      @named_method = NamedMethod.new @method
    end

    before :all do
      class Klass
        def method1
        end
        def method2(required_parameter,not_required_parameter="optional")
        end
      end
      @instance = Klass.new
    end

    describe "#initialize(method)" do
      it "create an alias to method" do
        method = @instance.method(:method1)
        NamedMethod.new method
        @instance.should respond_to :"___original_method1___"
      end
    end

    describe "#name_of_original" do
      it "is the name of original method" do
        method = @instance.method(:method1)
        named_method = NamedMethod.new(method)
        named_method.name_of_original.should be == :___original_method1___
      end
    end

    describe "#required_parameters" do
      it "is an array with all required parameters" do
        method = @instance.method(:method2)
        named_method = NamedMethod.new(method)
        named_method.required_parameters.should be == [:required_parameter]
      end
    end

    describe "#have_a_parameter_like?(arg_name)" do
      context 'given have a parameter named arg_name' do
        it "is true" do
          method = @instance.method(:method2)
          named_method = NamedMethod.new(method)
          the_return = named_method.have_a_parameter_like?(:required_parameter)
          the_return.should be_true
        end
      end
    end

    describe "#errors_when_called_with(parameters)" do
      before :each do
        Errors::RequiredParameters.stub!(:all_when).and_return([])
        Errors::UndefinedParameters.stub!(:all_when).and_return([])
        method = @instance.method(:method1)
        @named_method = NamedMethod.new(method)
      end

      describe "integrations" do
        it "Errors::UndefinedParameters.all_when(method,{called_with:args})" do
          Errors::UndefinedParameters.should_receive(:all_when)
                                     .and_return([])
          @named_method.errors_when_called_with(:args)
        end

        it "Errors::RequiredParameters.all_when(method,{called_with:args})" do
          Errors::RequiredParameters.should_receive(:all_when)
                                    .and_return([])
          @named_method.errors_when_called_with(:args)
        end
      end
    end
  end
end
