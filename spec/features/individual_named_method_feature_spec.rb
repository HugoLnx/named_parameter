require 'spec_helper'

describe "individual named method feature" do
  describe "becomes possible:" do
    describe 'Named Parameter' do
      specify %q{
        named def say(phrase)
          phrase
        end

        say phrase: "Hi!"
          # => "Hi!"
      } do
        module Kernel
          named def say(phrase)
            phrase
          end
        end

        phrase = @test.say phrase: "Hi!"
        phrase.should be == "Hi!"
      end
    end

    describe 'Optional Named Parameter' do
      specify %q{
        named def say(phrase="I'm mute")
          phrase
        end

        say
          # => "I'm mute"
      } do
        module Kernel
          named def say(phrase="I'm mute")
            phrase
          end
        end

        phrase = say
        phrase.should be == "I'm mute"
      end
    end

    describe 'Multiple Named Parameter (in any order)' do
      specify %q{
        named def move_to(x,y)
          [x,y]
        end

        move_to x: 1,y: 2
          # => [1,2]

        move_to y: 2, x: 1
          # => [1,2]
      } do
        module Kernel
          named def move_to(x,y)
            [x,y]
          end
        end

        position = move_to x: 1,y: 2
        position.should be == [1,2]

        position = move_to y: 2, x: 1
        position.should be == [1,2]
      end
    end

    describe 'ArgumentError when given undefined args' do
      specify %q{
        named def say(phrase)
        end

        say phrase: "hi!",undefined: "test"
          #=> ArgumentError
      } do
        module Kernel
          named def say(phrase)
          end
        end

        lambda{say(phrase: "hi!",undefined: "hugo")}.should raise_error ArgumentError, /'undefined'[\w\s]*'say'/
      end
    end

    describe 'ArgumentError when not given required args' do
      specify %q{
        named def say(phrase)
        end

        say
          #=> ArgumentError
      } do
        module Kernel
          named def say(phrase)
          end
        end

        lambda {say}.should raise_error ArgumentError, /'phrase'[\w\s]*'say'/
      end
    end
  end

  describe "no named method" do
    it "can be called with normal parameters" do
      module Kernel
        def no_named_say(phrase)
          phrase
        end
      end

      phrase = @test.no_named_say "Hi!"
      phrase.should be == "Hi!"
    end
  end
end
