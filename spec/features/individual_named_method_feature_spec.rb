require 'spec_helper'

describe "individual named method feature" do
  describe "becomes possible:" do
    describe 'Named Parameter' do
      specify %q{
        class People
          extend NamedParameter

          named def say(phrase)
            phrase
          end
        end

        People.new.say phrase: "Hi!"
          # => "Hi!"
      } do
        class People
          extend NamedParameter

          named def say(phrase)
            phrase
          end
        end

        phrase = People.new.say phrase: "Hi!"
        phrase.should be == "Hi!"
      end
    end

    describe 'Optional Named Parameter' do
      specify %q{
        class People
          extend NamedParameter

          named def say(phrase="I'm mute")
            phrase
          end
        end

        People.new.say
          # => "I'm mute"
      } do
        class People
          extend NamedParameter

          named def say(phrase="I'm mute")
            phrase
          end
        end

        phrase = People.new.say
        phrase.should be == "I'm mute"
      end
    end

    describe 'Multiple Named Parameter (in any order)' do
      specify %q{
        class Point
          extend NamedParameter

          named def move_to(x,y)
            [x,y]
          end
        end

        Point.new.move_to x: 1,y: 2
          # => [1,2]

        Point.new.move_to y: 2, x: 1
          # => [1,2]
      } do
        class Point
          extend NamedParameter

          named def move_to(x,y)
            [x,y]
          end
        end

        position = Point.new.move_to x: 1,y: 2
        position.should be == [1,2]

        position = Point.new.move_to y: 2, x: 1
        position.should be == [1,2]
      end
    end

    describe 'ArgumentError when given undefined args' do
      specify %q{
        class People
          extend NamedParameter
          named def say(phrase)
          end
        end

        People.new.say phrase: "hi!",undefined: "test"
          #=> ArgumentError
      } do
        class People
          named def say(phrase)
          end
        end

        lambda{People.new.say(phrase: "hi!",undefined: "hugo")}.should raise_error ArgumentError, /'undefined'[\w\s]*'say'/
      end
    end

    describe 'ArgumentError when not given required args' do
      specify %q{
        class People
          extend NamedParameter
          named def say(phrase)
          end
        end

        People.new.say
          #=> ArgumentError
      } do
        class People
          extend NamedParameter
          named def say(phrase)
          end
        end

        lambda {People.new.say}.should raise_error ArgumentError, /'phrase'[\w\s]*'say'/
      end
    end
  end

  describe "no named method" do
    it "can be called with normal parameters" do
      class People
        def no_named_say(phrase)
          phrase
        end
      end

      phrase = People.new.no_named_say "Hi!"
      phrase.should be == "Hi!"
    end
  end
end
