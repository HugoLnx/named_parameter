# Named Parameter `v0.0.1`

## Description
That you ever dream with named parameter in Ruby? Well, you doesn't have to pray to
Ruby's 2.0 have this, just install this gem and have fun!

## How it works
Just extend the module NamedParameter in your class/module and use the method 'named'
before define your method, when you call it, use a hash with parameters name as keys.
See this example:

    require 'rubygems'
    require 'named_parameter'
     
    class People
      extend NamedParameter
      
      named def say(phrase)
        puts "People says: #{phrase}"
      end
    end
    
    People.new.say phrase: "Awesome!"

Or maybe you want to define an optional parameter, no problem!

    require 'rubygems'
    require 'named_parameter'
     
    class People
      extend NamedParameter
      
      named def say(phrase="I'm mute")
        puts "People says: #{phrase}"
      end
    end
    
    People.new.say

Multiple arguments? Of course!

    require 'rubygems'
    require 'named_parameter'
     
    class Point
      extend NamedParameter
      
      named def move_to(x,y,z=0)
        puts "Moving to [#{x},#{y},#{z}]"
      end
    end
    
    Point.new.move_to(y: 30,x: 50)

## Use in production?
**You (maybe)**:"Oh! Magic! I'll use in my production projects!"
**Me**: Wait! Before use this in production, you have to know that gem
use the [method_added callback](http://ruby-doc.org/core/classes/Module.html#M000460), so if you want to use named parameter
and this callback in the same class, you have to use [around alias spell](https://gist.github.com/534772#file_around_alias.rb).

## How Install
Install the gem:

    gem install named_parameter
