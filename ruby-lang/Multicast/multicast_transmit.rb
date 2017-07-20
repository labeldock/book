#!/usr/bin/ruby
require_relative 'multicast.rb'
puts "Send Message : #{ARGV[0]}"
(Multicast::Client.new).transmit ARGV[0], ARGV[1]