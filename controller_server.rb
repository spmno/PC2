require 'socket'
require 'json'

class ControllerServer
  def initialize
    @server = TCPServer.new 9876
    @server_container = {}
    @read_thread_container = []
  end

  def start
    loop do
      client = @server.accept
      init_str = client.readline
      init_hash = JSON.parser init_str
      if init_hash['type'] == 'init' and init_hash['name'] == 'pad'
        @server_container['pad'] = client
      else
        @server_container['pc2'] = client
      end
    end
  end

  def read_func(client)
    command_str = client.readline


  end

end