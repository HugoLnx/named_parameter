require 'spec_helper'

describe "inline named" do
  describe "class << self named method feature" do
    describe "becomes possible:" do
      describe 'Named Parameter' do
        specify %q{
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
                phrase
              end
            end
          end

          People.say phrase: "Hi!"
            # => "Hi!"
        } do
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
                phrase
              end
            end
          end

          phrase = People.say phrase: "Hi!"
          phrase.should be == "Hi!"
        end
      end

      describe 'Optional Named Parameter' do
        specify %q{
          class People
            extend NamedParameter

            class << self
              named def say(phrase="I'm mute")
                phrase
              end
            end
          end

          People.say
            # => "I'm mute"
        } do
          class People
            extend NamedParameter

            class << self
              named def say(phrase="I'm mute")
                phrase
              end
            end
          end

          phrase = People.say
          phrase.should be == "I'm mute"
        end
      end

      describe 'Multiple Named Parameter (in any order)' do
        specify %q{
          class Point
            extend NamedParameter

            class << self
              named def move_to(x,y)
                [x,y]
              end
            end
          end

          Point.move_to x: 1,y: 2
            # => [1,2]

          Point.move_to y: 2, x: 1
            # => [1,2]
        } do
          class Point
            extend NamedParameter

            class << self
              named def move_to(x,y)
                [x,y]
              end
            end
          end

          position = Point.move_to x: 1,y: 2
          position.should be == [1,2]

          position = Point.move_to y: 2, x: 1
          position.should be == [1,2]
        end
      end

      describe 'ArgumentError when given undefined args' do
        specify %q{
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          People.say phrase: "hi!",undefined: "test"
            #=> ArgumentError
        } do
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          lambda{People.say(phrase: "hi!",undefined: "hugo")}.should raise_error ArgumentError, /'undefined'[\w\s]*'say'/
        end
      end

      describe 'ArgumentError when not given required args' do
        specify %q{
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          People.say
            #=> ArgumentError
        } do
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          lambda {People.say}.should raise_error ArgumentError, /'phrase'[\w\s]*'say'/
        end
      end

      describe 'ArgumentError when given a non Hash argument' do
        specify %q{
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          People.say
            #=> ArgumentError
        } do
          class People
            extend NamedParameter

            class << self
              named def say(phrase)
              end
            end
          end

          lambda {People.say("non Hash argument")}.should raise_error ArgumentError, /"non Hash argument"[\w\s]*'say'/
        end
      end
    end

    describe "no named method" do
      it "can be called with normal parameters" do
        class People
          class << self
            def no_named_say(phrase)
              phrase
            end
          end
        end

        phrase = People.no_named_say "Hi!"
        phrase.should be == "Hi!"
      end
    end
  end
end
