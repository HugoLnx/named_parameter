require 'spec_helper'

module NamedParameter
  describe NamedMethodTransmuter do
    before :each do
      @klass = Class.new do
        def method1
        end

        def method2(param1)
          param1
        end
      end
      @instance = @klass.new
    end

    describe ".transmute(method)" do
      describe "integrations" do
        it "NamedMethod.new(method)" do
          method = @klass.instance_method(:method1)
          NamedMethod.should_receive(:new).with(method)
          NamedMethodTransmuter.transmute method
        end
      end

      it "override old method to a mirror that receive hash" do
        method = @instance.method(:method2)
        NamedMethodTransmuter.transmute method
        @instance.should be_respond_to(:method2, param1: "teste")
      end

      describe "mirror method" do
        describe "integrations" do
          specify "NamedMethod#name_of_original(parameters)" do
            method = @klass.instance_method(:method1)
            named_method = NamedMethod.new(method)
            NamedMethod.stub!(:new => named_method)
            @instance.stub_chain(:method,:call)
            NamedMethodTransmuter.transmute method
            named_method.should_receive(:name_of_original)
            @instance.method1
          end

          specify "NamedMethod#errors_when_called_with(args)" do
            NamedMethod.method_defined?(:errors_when_called_with).should be_true
            method = @klass.instance_method(:method1)
            named_method = NamedMethod.new(method)
            NamedMethod.stub!(:new => named_method)
            NamedMethodTransmuter.transmute method
            named_method.should_receive(:errors_when_called_with)
                        .and_return([])
            @instance.method1
          end

          specify "Errors::SomeError#raise_args" do
            method = @klass.instance_method(:method1)
            errors = stub(:errors)
            NamedMethod.stub_chain(:new,:errors_when_called_with)
                       .and_return(errors)
            error = stub(:error)
            errors.stub!(:first)
                  .and_return(error)
            errors.stub!(:empty?)
                  .and_return(false)
            NamedMethodTransmuter.transmute method
            error.should_receive(:raise_args)
                 .and_return([])
            lambda{@instance.method1}.should raise_error ArgumentError
          end
        end
      end
    end
  end
end
