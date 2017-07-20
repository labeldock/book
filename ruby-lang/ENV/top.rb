#!/usr/bin/ruby

def read_top 
  result = []
  if RUBY_PLATFORM.match 'darwin'
    IO.foreach('|top -l1'){ |line| result.push line }
  elsif RUBY_PLATFORM.match 'linux'
    IO.foreach('|top -n1'){ |line| result.push line }
  end
  result.join
end