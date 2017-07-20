

# base code by https://github.com/jpignata/backchannel/blob/master/lib/backchannel

require "json"
require "socket"
require "thread"
require "ipaddr"
require "securerandom"

module Multicast
  
  class Messege
    attr_reader :client_id, :recive_alias, :content

    def self.inflate(json)
      attributes = JSON.parse(json)
      new(attributes)
    end

    def initialize(attributes={})
      @client_id    = attributes.fetch("client_id")
      @client_id    ||= ""
      @recive_alias = attributes.fetch("recive_alias")
      @recive_alias ||= "*"
      @content      = attributes.fetch("content")
    end

    def to_json
      { client_id: client_id, recive_alias: recive_alias, content: content }.to_json
    end
  end
  
  class Listener
    attr_reader :recive_alias
    
    def initialize(recive_alias="*",proc=nil,&block)
      @recive_alias = recive_alias
      @handle = block_given? ? block : proc
    end
    
    def new_message(message)
      @handle.call(message.content) if @handle
    end
  end

  class Client
    MULTICAST_ADDR = "224.0.0.1"
    BIND_ADDR = "0.0.0.0"
    PORT = 6811

    def initialize()
      @client_id = SecureRandom.hex(5)
      @listeners = []
    end
    
    
    def add_message_listener(listener)
      listen unless listening?
      @listeners << listener
      listener
    end
    
    def new_message_listener(recive_alias="*",&block)
      self.add_message_listener Listener.new(recive_alias,block)
    end
    
    def transmit(content,recive_alias="*")
      message = Messege.new(
        "client_id" => @client_id,
        "recive_alias" => recive_alias,
        "content"   => content
      )
      socket.send(message.to_json, 0, MULTICAST_ADDR, PORT)
      message
    end
  
    private

    def listen
      socket.bind(BIND_ADDR, PORT)

      Thread.new do
        loop do
          attributes, _ = socket.recvfrom(1024)
          message = Messege.inflate(attributes)
          unless message.client_id == @client_id
            @listeners.each{ |listener| 
              if listener.recive_alias == message.recive_alias
                listener.new_message(message) 
              end
            }
          end
        end
      end
      @listening = true
    end

    def listening?
      @listening == true
    end

    def socket
      @socket ||= UDPSocket.open.tap do |socket|
        socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, bind_address)
        socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_MULTICAST_TTL, 1)
        socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
      end
    end

    def bind_address
      IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(BIND_ADDR).hton
    end
  end

 
  
end

