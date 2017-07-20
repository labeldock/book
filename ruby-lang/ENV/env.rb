#!/usr/bin/ruby

def put_section (section_name)
  puts "## #{section_name}"
  yield
  puts "\n"
end

put_section 'Command' do
  puts "- ARGV : #{ARGV}"
end

put_section 'File' do
  puts "- file : #{__FILE__}"
  puts "- current dirctory : #{File.expand_path("../", __FILE__)}"
  puts "- parent directory : #{File.expand_path("../../", __FILE__)}"
end

put_section 'Ruby' do
  puts "- Ruby Version : #{RUBY_VERSION}"
  puts "- Load path : #{$LOAD_PATH}"
end

put_section 'Debug' do 
  puts "- line number : #{__LINE__}"
end

put_section 'Net' do
  require 'socket'
  ipv4 = UDPSocket.open {|s| s.connect('64.233.187.99', 1); s.addr.last }
  #current ip
  puts "- ipv4 : #{ ipv4 }"
  #check private ip
  puts "- private? : #{ (ipv4.match /^(10.|172.((1|2)[\d].|(30|31))|192.168.)/) ? true : false }"
end









