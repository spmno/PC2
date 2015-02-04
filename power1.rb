require_relative 'power'
require_relative 'mx_logger'

class Power1 < Power

  def initialize(id, serial)
    super(id, serial)
  end

  def on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x11"
    @serial_port.write command
  end

  def off
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x10"
    @serial_port.write command
  end

end