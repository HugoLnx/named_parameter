require 'spec_helper'

describe NamedMethod do
  before :each do
    @method = stub(:method).as_null_object
    @named_method = NamedMethod.new @method
  end

	before :all do
		class Klass
			def method1
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

  describe "#errors_when_called_with(parameters)" do
    describe "integrations" do
      it "Method#parameters" do
        @method.should_receive(:parameters).at_least(:once).and_return([[]])
        @named_method.errors_when_called_with({:param1 => "value"})
      end
    end

    context "given valid arguments" do
      describe "return" do
        it "will be an empty array" do
          @method.stub!(:parameters => [[:req,"param1"]])
          errors = @named_method.errors_when_called_with({:param1 => "value"})
          errors.should be == []
        end
      end
    end

		context "given method have no parameters" do
      describe "return" do
        it "will be an empty array" do
          @method.stub!(:parameters => [])
          errors = @named_method.errors_when_called_with({})
          errors.should be == []
        end
      end
		end

    context "given extra arguments" do
      describe "return" do
        before :each do
          @method.stub!(:parameters => [[]])
          @return = @named_method.errors_when_called_with({:param1 => "value"})
        end

        it "will be an array" do
          @return.should be_a_kind_of Array
        end
        
        it "will be composed of arrays with 2 elements" do
          @return.each do |elements|
            elements.should have(2).elements
          end
        end

        describe "2 elements" do
          before :each do
            @elements = @return.first
          end

          it "first is the error message" do
            @elements.first.should be_a String
          end

          it "second is the backtrace of errors" do
            @elements[1].should be_a Array
          end
        end
      end
    end

    context "not given required argument" do
      describe "return" do
        before :each do
          @method.stub!(:parameters => [[:req,"param1"]])
          @return = @named_method.errors_when_called_with({})
        end

        it "will be an array" do
          @return.should be_a_kind_of Array
        end
        
        it "will be composed of arrays with 2 elements" do
          @return.each do |elements|
            elements.should have(2).elements
          end
        end

        describe "2 elements" do
          before :each do
            @elements = @return.first
          end

          it "first is the error message" do
            @elements.first.should be_a String
          end

          it "second is the backtrace of errors" do
            @elements[1].should be_a Array
          end
        end
      end
    end
  end
end
