# encoding:ascii-8bit
require_relative 'protocol'

class Door < Protocol
  attr_accessor :id, :serial_port

  def initialize(id, serial)
    @id, @serial_port = id, serial
  end

  def execute(command)
    case command
      when 'open' then open
      when 'close' then close
      else
        MXLogger.debug 'Unknown command'
        raise 'Unknown command'
    end
  end

  def open
    MXLogger.debug self.class.to_s + __method__.to_s
    command = make_command @id, "\x02"
    @serial_port.write command
  end

  def close
    MXLogger.debug self.class.to_s + __method__.to_s
    command = make_command @id, "\x01"
    @serial_port.write command
  end
end