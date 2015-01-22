# encoding:utf-8
require 'serialport'
require './mx_logger'

class MXSerialPort
  def initialize(port, baudrate=115200)
    @port = port
    @baudrate = baudrate
    @serial_port = SerialPort.new(@port, "115200".to_i)
    @serial_port.set_encoding("UTF-8")
    @buf = []
  end

  def read_func
    MXLogger.debug "read func run!!!"
    loop do
      read_buf = @serial_port.gets("\xDD\xDD")
      #read_buf = @serial_port.gets(8)
      sleep(2)
      if read_buf
        @buf = read_buf.bytes
        p @buf, @buf.size
        if @buf[2] == 0 and @buf[3] == 0
          p "good"
          read_buf[0] = "\xCF"
          read_buf[1] = "\xCF"
          @serial_port.write read_buf
        end
      end
    end
  end

  def write
    a = ['\xCF', '\xCF', 0, 0, '\x73', '\x11' '\xDD', '\xDD']
    @serial_port.write a.to_s
  end
end