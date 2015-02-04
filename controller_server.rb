require 'socket'
require 'json'
require 'observer'
require_relative 'mx_logger'

class ControllerServer
  include Observable

  def initialize
    @server = TCPServer.new "0.0.0.0", 9876
    @server_container = {}
    @read_thread_container = []
  end

  def start
    MXLogger.debug "controller server start."
    loop do
      client = @server.accept
      MXLogger.debug "server accepted client = #{client}."
      init_str = client.readline
      init_hash = JSON.parse init_str
      if init_hash['type'] == 'init' and init_hash['name'] == 'pad'
        @server_container['pad'] = client
        MXLogger.debug 'pad client connected.'
      else
        @server_container['pc2'] = client
        MXLogger.debug 'pc2 client connected.'
      end
      changed
      notify_observers init_str
      Thread.new { read_func client }
    end
  end

  def read_func(client)
    MXLogger.debug "read function start #{client}."
    loop do
      command_str = client.readline
      MXLogger.debug "receive #{command_str}."
      changed
      notify_observers command_str
    end
  end

end