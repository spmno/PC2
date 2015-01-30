require 'json'
require_relative  'mx_serial_port'
require_relative 'controller_server'
require_relative 'mx_logger'
require_relative 'protocol'
require_relative 'chair_controller'
require_relative 'part_factory'
require_relative 'global_config'
require_relative 'serial_distributor'

class PC2
  def initialize
    @serial_port_list = []
    @threads = []
    @controller_server = ControllerServer.new
    @part_factory = PartFactory.new
    SerialDistributor.instance.init_serials
    #@chair_controller = ChairController.new "\\\\.\\COM15"
    #init_serial_port
    init_socket_server
  end

  def init_socket_server
    @threads << Thread.new { @controller_server.start }
    @controller_server.add_observer self, :update_socket
  end

  def init_serial_port
      @serial_port_test = MXSerialPort.new "COM7"
      @serial_port_list.push @serial_port_test
      #@threads << Thread.new { serial_port_test.read_func }
      #@serial_port_test.write_on
      #@serial_port_test.write_off
      #@threads << Thread.new { @serial_port_test.write }
#  rescue
#      MXLogger.error "open serial port failed."
  end

  def wait
    @threads.each { |thr| thr.join }
  end

  def update_socket(result)
    MXLogger.debug "update socket #{result}"
    protocol_hash = JSON.parse result
    part = @part_factory.create protocol_hash['part']
    MXLogger.debug "create part #{part}."
    part.execute protocol_hash['action'] if part
    MXLogger.debug "end update socket"
  end

end

pc2 = PC2.new
pc2.wait

