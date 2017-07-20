#!/usr/bin/ruby

class Foo
  def initialize (&block)
    puts "inti!! #{ self } #{block}"
    obj = {foo: 'bar'}
    
    if block_given?
      yield
      instance_eval &block
      obj.instance_eval &block
      1992.instance_eval &block
      ['bar'].instance_eval &block
    end
  end
end

Foo.new do 
  puts "self is #{ self }"
end

