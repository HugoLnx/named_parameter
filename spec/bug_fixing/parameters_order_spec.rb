require 'spec_helper'

describe "BugFix: Parameters order spec" do
  describe 'Named Parameter' do
    context %q{named def whatever(a="z",b="z",c="z",d="z",e="z",f="z")} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a="z",b="z",c="z",d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a z c d z f}
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a="z",b="z",c="z",d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a z c d z f}
        end
      end
    end

    context %q{named def whatever(a="z",b="z",c="z", \n d="z",e="z",f="z")} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a="z",b="z",c="z",
                               d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a z c d z f}
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a="z",b="z",c="z",
                         d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a z c d z f}
        end
      end
    end


    context %q{named def whatever(a="z",b="z",c="z", d="z",e,f)} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a,b,c="z", d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            b: "b",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a b c d z f}
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a,b,c="z", d="z",e="z",f="z")
              return [a,b,c,d,e,f]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            b: "b",
            c: "c",
            d: "d",
            f: "f"
          ).should == %w{a b c d z f}
        end
      end
    end

    context %q{named def whatever(a,b="z",c=lambda{|arg1,arg2| arg1 + "test"})} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a,b="z",c=lambda{|arg1,arg2| arg1 + "test"},d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          return_ = obj.whatever(
            a: "a",
            d: "d"
          )
          return_[0].should == "a"
          return_[1].should == "z"
          return_[2].should be_a Proc
          return_[3].should == "d"
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a,b="z",c=lambda{|arg1,arg2| arg1 + "test"},d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          return_ = obj.whatever(
            a: "a",
            d: "d"
          )
          return_[0].should == "a"
          return_[1].should == "z"
          return_[2].should be_a Proc
          return_[3].should == "d"
        end
      end
    end

    context %q{named def whatever(a,b="z",c="z,z",d="z")} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a,b="z",c="z,z",d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            d: "d"
          ).should == %w{a z z,z d}
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a,b="z",c="z,z",d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            d: "d"
          ).should == %w{a z z,z d}
        end
      end
    end

    context %q{named def whatever(a,b="z",c=/z,z/,d="z")} do
      context "inline" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named def whatever(a,b="z",c=/z,z/,d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            d: "d"
          ).should == ["a", "z", /z,z/, "d"]
        end
      end

      context "above" do
        specify "parameters maintain order" do
          class SomeClass
            extend NamedParameter

            named
            def whatever(a,b="z",c=/z,z/,d="z")
              return [a,b,c,d]
            end
          end

          obj = SomeClass.new
          
          obj.whatever(
            a: "a",
            d: "d"
          ).should == ["a", "z", /z,z/, "d"]
        end
      end
    end

  end
end
