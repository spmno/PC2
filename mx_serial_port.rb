# encoding:ascii-8bit
require 'rubyserial'
require_relative 'mx_logger'

class MXSerialPort
  def initialize(port, baudrate=115200)
    @port = port
    @baudrate = baudrate
    #begin
    @serial_port = Serial.new(@port, "115200".to_i)
    #rescue RubySerial::Exception
    #  MXLogger.debug "open serial port failed."
    #end
    #@serial_port_read = SerialPort.new(@port, 115200)
    #@serial_port.set_encoding("UTF-8")
    @buf = []
  end

  def read_func
    MXLogger.debug "read func run!!!"
    loop do
      read_buf = @serial_port.read(8)
      #read_buf = @serial_port.gets("\xDD\xDD",8)
      #read_buf = @serial_port.gets(8)
      #sleep(2)
      if read_buf
        @buf = read_buf.bytes
        p @buf, @buf.size
        @buf.each do |c|
          print c.to_s(16)
        end
        if @buf[2] == 0 and @buf[3] == 0
          p "good"
          read_buf[0] = "\xCF"
          read_buf[1] = "\xCF"
          puts "write:"
          log_buf = read_buf.bytes
          log_buf.each do |c|
            print c.to_s(16)
          end
          puts "write end"
          sleep(1)
          @serial_port.write read_buf

        end
      end
    end
  end

  def write
    loop do
      #a = %q["\xCF" "\xCF" 0  0 "\x73" "\x21" "\xDD" "\xDD"]
      a = ""
      a[0] = "\xCF"
      a[1] = "\xCF"
      a[2] = "\x00"
      a[3] = "\x00"
      a[4] = "\x73"
      a[5] = "\x21"
      a[6] = "\xDD"
      a[7] = "\xDD"
      @serial_port.write a
      puts "send1"
      sleep(1)
      a[0] = "\xCF"
      a[1] = "\xCF"
      a[2] = "\x00"
      a[3] = "\x00"
      a[4] = "\x73"
      a[5] = "\x20"
      a[6] = "\xDD"
      a[7] = "\xDD"
      @serial_port.write a
      puts "send2"
      sleep(1)
    end
  end

  def write_on
    puts "write on"
    a = ""
    a[0] = "\xCF"
    a[1] = "\xCF"
    a[2] = "\x00"
    a[3] = "\x00"
    a[4] = "\x73"
    a[5] = "\x21"
    a[6] = "\xDD"
    a[7] = "\xDD"
    @serial_port.write a
  end

  def write_off
    puts "write off"
    a = ""
    a[0] = "\xCF"
    a[1] = "\xCF"
    a[2] = "\x00"
    a[3] = "\x00"
    a[4] = "\x73"
    a[5] = "\x20"
    a[6] = "\xDD"
    a[7] = "\xDD"
    @serial_port.write a
  end

end