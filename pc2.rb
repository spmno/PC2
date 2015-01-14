require './mx_serial_port'
require './controller_server'

class PC2
  def initialize
    @serial_port_list = []
    @threads = []
    @controller_server = ControllerServer.new
    init_serial_port
  end

  def init_socket_server

  end

  def init_serial_port
    serial_port_test = MXSerialPort.new "COM6"
    @serial_port_list.push serial_port_test
    @threads << Thread.new { serial_port_test.read_func }
  end

  def wait
    @threads.each { |thr| thr.join }
  end
end

pc2 = PC2.new
pc2.wait

