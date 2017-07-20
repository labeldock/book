#!/usr/bin/ruby

require_relative 'top'

result = {}

if RUBY_PLATFORM.match 'darwin'
  top_text = read_top
  
  result[:cpu_use] = top_text.match(/CPU usage: ([\d\.]+)/)[1]
  result[:mem]     = top_text.match(/PhysMem: ([\d]+)/)[1]
  result[:mem_use] = result[:mem].to_i - top_text.match(/(\d+)M unused./)[1].to_i
  
else RUBY_PLATFORM.match 'linux'
  top_text = read_top 
  #Bug:수정중
  #result[:cpu_use] = top_text.match(/%Cpu(s):\s+([\d\.]+)/)[1]
  #result[:mem]     = top_text.match(/([\d]+) total/)[1]
  #result[:mem_use] = top_text.match(/([\d]+) used/)[1]
end

puts result