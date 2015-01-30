# encoding:ascii-8bit
require_relative 'protocol'

class Lock < Protocol
  attr_accessor :id, :name

  def initialize(id, name)
    @id, @name = id, name
    @serial_port = SerialDistributor.instance.get_serial @name
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
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x01"
    @serial_port.write command
  end

  def close
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x02"
    @serial_port.write command
  end
end