require 'socket'
require 'json'
require './mx_logger'

class ControllerServer
  def initialize
    @server = TCPServer.new "0.0.0.0", 9876
    @server_container = {}
    @read_thread_container = []
  end

  def start
    MXLogger.debug "controller server start"
    loop do
      client = @server.accept
      MXLogger.debug "server accepted client = #{client} "
      init_str = client.readline
      init_hash = JSON.parser init_str
      if init_hash['type'] == 'init' and init_hash['name'] == 'pad'
        @server_container['pad'] = client
      else
        @server_container['pc2'] = client
      end
      Thread.new { read_func client }
    end
  end

  def read_func(client)
    command_str = client.readline
  end

end