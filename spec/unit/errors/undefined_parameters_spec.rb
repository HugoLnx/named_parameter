require 'spec_helper'

module NamedParameter::Errors
  describe UndefinedParameters do
    describe '#initialize(error)' do
      describe 'initialize instance variables' do
        specify '@error its equal to error' do
          specific_error = UndefinedParameters.new :error
          specific_error.instance_variable_get(:@error).should be == :error
        end
      end
    end

    describe '#raise_args' do
      before :each do
        # prevention from dependencies
        @error = stub(:error).as_null_object
        @error.stub_chain('named_method.method.name')
      end

      let :instance do
        UndefinedParameters.new @error
      end

      describe 'return' do
        let :the_return do
          instance.raise_args
        end

        it 'is an array of 2 elements' do
          the_return.should be_an Array
          the_return.should have(2).elements
        end


        describe 'first element' do
          let :first_element do
            the_return.first
          end

          it 'is a String of the error message' do
            first_element.should be_a String
          end

          it 'include the name of argument envolved in the error' do
            @error.stub :argument_name => 'arg_name'
            first_element.should include 'arg_name'
          end

          it 'include the name of method envolved in the error' do
              @error.stub_chain('named_method.method.name').and_return('method_name')
            first_element.should include 'method_name'
          end
        end


        describe 'second element' do
          let :second_element do
            the_return[1]
          end

          it 'is an Array of backtrace' do
            backtrace = [:backtrace]
            @error.stub(:backtrace).and_return(backtrace)
            second_element.should be == backtrace
          end
        end
      end
    end

    describe '.all_when(named_method,{called_with:args})' do
      describe 'return' do
        before :each do
          @named_method = stub(:named_method, 
                               :parameters => [[:req,:param1]],
                               :have_a_parameter_like? => false)
          @args = {:arg_name => :value}
        end

        let :the_return do
          UndefinedParameters.all_when(@named_method,:called_with => @args)
        end
        
        it 'is an Array' do
          the_return.should be_an Array
        end

        context 'given some arg does not exist in method parameters' do
          it 'have one element' do
            @named_method.stub!(:have_a_parameter_like? => false)
            the_return.should have(1).element
          end
        end

        context 'given all arguments exist in method parameters' do
          it 'is empty' do
            @named_method.stub!(:have_a_parameter_like? => true)
            the_return.should be == []
          end
        end
      end
    end
  end
end
