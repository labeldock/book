#!/usr/bin/ruby
#ticket_messege는 메시지를 보낸후 지정된 시간만큼 recive 메시지를 기다리고 실행합니다.
require_relative 'multicast.rb'

(->{
  recives = [];
  @client = Multicast::Client.new
  @client.new_message_listener('ipv4request-recive') do |ipv4|
    recives << ipv4
  end
  
  @client.transmit nil,'ipv4request'
  
  sleep 0.4
  puts "ipv4recive #{ recives }"
}).call
