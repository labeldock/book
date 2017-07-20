#!/usr/bin/ruby

require_relative 'multicast.rb'

(->{
  @client = Multicast::Client.new
  
  @client.new_message_listener('*'){ |massage|
    puts "recive message => #{massage}"
  }

  @client.new_message_listener('ipv4request'){ |massage|
    puts "client::ipv4request recive!"
    require 'socket'
    @client.transmit( UDPSocket.open{ |s| s.connect('64.233.187.99', 1); s.addr.last }, 'ipv4request-recive' )
  }
  
  #wait
  puts "Multicast Start"
  multicast_time = 0
  loop do;
    sleep 10;
    multicast_time += 1
    puts "server is started after #{ multicast_time * 10 } seconds.."
  end
}).call


