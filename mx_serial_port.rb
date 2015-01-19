require 'serialport'
require './mx_logger'

class MXSerialPort
  def initialize(port, baudrate=115200)
    @port = port
    @baudrate = baudrate
    @serial_port = SerialPort.new(@port, "115200".to_i)
    @buf = []
  end

  def read_func
    MXLogger.debug "read func run!!!"
    loop do
      read_buf = @serial_port.read(12)
      if read_buf != nil
        @buf = read_buf.bytes
        p @buf
      end
    end
  end

end