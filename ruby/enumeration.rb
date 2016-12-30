#!/usr/bin/ruby

data = [1,2,3,4,5]

puts '## 1'
data.each do |n|
    puts n
end

puts '## 2'
data.each { |n| puts n }


puts '## 3'
data = { face1: '111', face2: '222', face3: '333' }
puts data

puts '## 4'
data.each do |v|
    puts "v[0] : #{v[0]}"
    puts "v[1] : #{v[1]}"
end

puts '## 5'
data.each do |v,i|
    puts "v : #{v}"
    puts "i : #{i}"
end

puts '## 6'
for v in data do
    puts "v[0] : #{v[0]}"
    puts "v[1] : #{v[1]}"
end

puts '## 7'
data.length.times do |t| 
    puts t
end