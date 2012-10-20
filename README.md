# Named Parameter `v1.0.2`

## Description
That you ever dream with named parameter in Ruby? Well, you doesn't have to pray to
Ruby's 2.0 have this, just install this gem and have fun!

## How Install
Install the gem:

    gem install named_parameter

## How use it
Just extend the module NamedParameter in your class/module and use the method 'named'
before define your method, when you call it, use a hash with parameters name as keys.

### It's just simple and clean:

    require 'rubygems'
    require 'named_parameter'
     
    class People
      extend NamedParameter
      
      named def say(phrase)
        puts "People says: #{phrase}"
      end
    end
    
    People.new.say phrase: "Awesome!"

### We can also call named above method definition

    require 'rubygems'
    require 'named_parameter'
     
    class People
      extend NamedParameter
      
      named
      def say(phrase)
        puts "People says: #{phrase}"
      end
    end
    
    People.new.say phrase: "Awesome!"

### Maybe you want to use optional arguments, no problem!

    require 'rubygems'
    require 'named_parameter'
     
    class People
      extend NamedParameter
      
      named def say(phrase="I'm mute")
        puts "People says: #{phrase}"
      end
    end
    
    People.new.say

### Multiple arguments? Of course!

    require 'rubygems'
    require 'named_parameter'
     
    class Point
      extend NamedParameter
      
      named def move_to(x,y,z=0)
        puts "Moving to [#{x},#{y},#{z}]"
      end
    end
    
    Point.new.move_to(y: 30,x: 50)


### If you like singleton classes you will love that:

    require 'rubygems'
    require 'named_parameter'
     
    class Point
      extend NamedParameter
      
      named def self.move_to(x,y,z=0)
        puts "Moving to [#{x},#{y},#{z}]"
      end
    end
    
    Point.move_to(y: 30,x: 50)


### And that feature too:

    require 'rubygems'
    require 'named_parameter'
     
    class Point
      extend NamedParameter
      
      class << self
        named def move_to(x,y,z=0)
          puts "Moving to [#{x},#{y},#{z}]"
        end
      end
    end
    
    Point.move_to(y: 30,x: 50)


## Can I use in production?
The answer is: **YES**  
But you have to know that gem
use the [method_added callback](http://ruby-doc.org/core/classes/Module.html#M000460), so if you want to use named parameter
and this callback in the same class, you have to use [around alias spell](https://gist.github.com/534772#file_around_alias.rb).
So you can use in production, but be careful using it in classes manipulated by other libraries.
