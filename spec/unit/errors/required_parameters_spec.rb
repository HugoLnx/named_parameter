require 'spec_helper'

module Errors
  describe RequiredParameters do
    describe '#initialize(error)' do
      describe 'initialize instance variables' do
        specify '@error its equal to error' do
          specific_error = RequiredParameters.new :error
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
        RequiredParameters.new @error
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



      describe 'integrations' do
        after :each do
          instance.raise_args
        end

        specify '@error.argument_name' do
          @error.should_receive :argument_name
        end

        specify '@error.named_method' do
          @error.should_receive :named_method
        end
      end
    end

    describe '.all_when(named_method,{called_with:arg})' do
      describe 'return' do
        before :each do
          @named_method = stub(:named_method, 
                               :parameters => [[:req,:param1]],
                               :required_parameters => [:param1],
                               :have_a_parameter_like? => false)
          @args = {:arg_name => :value}
        end

        let :the_return do
          RequiredParameters.all_when(@named_method,:called_with => @args)
        end
        
        it 'is an Array' do
          the_return.should be_an Array
        end

        context 'given some required parameter wasn\'t passed' do
          it 'have one element' do
            @args = {}
            the_return.should have(1).element
          end
        end

        context 'given all required parameters was passed' do
          it 'is empty' do
            @args = {:param1 => 'value1'}
            the_return.should be_empty
          end
        end
      end

      describe 'integrations' do
        specify "named_method.required_parameters" do
          named_method = stub(:named_method)
          named_method.should_receive(:required_parameters)
                      .and_return([])
          RequiredParameters.all_when(named_method,:called_with => [])
        end
      end
    end
  end
end
