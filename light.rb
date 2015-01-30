# encoding:ascii-8bit
require_relative 'mx_logger'
require_relative 'protocol'
require_relative 'mx_logger'

class Light < Protocol
  attr_accessor :id, :name

  def initialize(id, name)
    @id, @name = id, name
    @serial_port = SerialDistributor.instance.get_serial @name
  end

  def execute(command)
    MXLogger.debug self.class.to_s + __method__.to_s
    case command
      when 'on' then on
      when 'off' then off
      else
        MXLogger.debug 'Unknown command'
        raise 'Unknown command'
    end
  end

  def on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x02"
    @serial_port.write command
  end

  def off
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x00"
    @serial_port.write command
  end

end