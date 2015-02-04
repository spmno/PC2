require_relative 'door'

class IrisDoor < Door
  def initialize(serial)
    @id, @serial_port = "\x31", serial
    @thread = Thread.new { read_func }
    @read_buf = ''
    MXLogger.debug 'IrisDoor init'
  end

  def open
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x00"
    @serial_port.write command
  end

  def close
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x01"
    @serial_port.write command
  end

  def read_func
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    MXLogger.debug @serial_port
    #loop do
    #  @read_buf = @serial_port.read(8)
      #MXLogger.debug 'read data.'
    #end

    #read_buf[0] = "\xCF"
    #read_buf[1] = "\xCF"
    #@serial_port.write read_buf
  end

end