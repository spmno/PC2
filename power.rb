require_relative 'mx_logger'

class Power
  attr_accessor :id, :serial_port

  def initialize(id, serial)
    @id, @serial_port = id, serial
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

end