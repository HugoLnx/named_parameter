require 'spec_helper'

module NamedParameter
  describe Error do
    describe '#initialize(named_method,argument,full_backtrace)' do
      describe 'initialize instance variables' do
        before :each do
          @named_method = stub :named_method
          @argument_name = []
          @full_backtrace = []
          @error = Error.new(@named_method,@argument_name,@full_backtrace)
        end

        specify '@named_method its equal to named_method' do
          @error.instance_variable_get(:@named_method).should be == @named_method
        end

        specify '@argument_name its equal to argument_name' do
          @error.instance_variable_get(:@argument_name).should be == @argument_name
        end

        specify '@backtrace its equal to full_backtrace without two first slots' do
          full_backtrace = [1,2,3]
          error = Error.new(@named_method,@argument_name,full_backtrace)
          error.instance_variable_get(:@backtrace).should be == [3]
        end
      end
    end
  end
end
