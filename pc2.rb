require 'json'
require_relative  'mx_serial_port'
require_relative 'controller_server'
require_relative 'mx_logger'
require_relative 'protocol'
require_relative 'chair_controller'
require_relative 'part_factory'
require_relative 'global_config'
require_relative 'part_distributor'

class PC2
  def initialize
    @serial_port_list = []
    @threads = []
    @controller_server = ControllerServer.new
    init_socket_server
    PartDistributor.instance.init_parts
    MXLogger.debug 'init finished'
  end

  def init_socket_server
    @threads << Thread.new { @controller_server.start }
    @controller_server.add_observer self, :update_socket
  end

  def wait
    @threads.each { |thr| thr.join }
  end

  def update_socket(result)
    MXLogger.debug "update socket #{result}"
    protocol_hash = JSON.parse result
    part = PartDistributor.instance.get_part protocol_hash['part']
    MXLogger.debug "get part #{part}."
    part.execute protocol_hash['action'] if part
    MXLogger.debug 'end update socket'
  end

end

pc2 = PC2.new
pc2.wait
MXLogger.debug 'program over'

puts "over"