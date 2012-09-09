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
  end
end
