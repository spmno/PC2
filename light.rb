# encoding:ascii-8bit
require_relative 'mx_logger'
require_relative 'protocol'
require_relative 'mx_logger'

class Light < Protocol
  attr_accessor :id, :serial_port

  def initialize(id, serial)
    @id, @serial_port = id, serial_port
  end

  def execute(command)
    MXLogger.debug self.class.to_s + __method__.to_s
    case command
      when 'on' then on
      when 'off' then off
      when 'red-on' then red_on
      when 'red-little' then red_little
      when 'green-on' then green_on
      when 'green-little' then green_little
      when 'blue-on' then blue_on
      when 'blue-little' then blue_little
      when 'mix-on' then mix_on
      when 'mix-little' then mix_little
      when /\d+/ then adjust
      else
        MXLogger.debug 'Unknown command'
        raise 'Unknown command'
    end
  end

  def on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x01"
    @serial_port.write command
  end

  def off
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x00"
    @serial_port.write command
  end

  def red_on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x11"
    @serial_port.write command
  end

  def red_little
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x12"
    @serial_port.write command
  end

  def green_on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x21"
    @serial_port.write command
  end

  def green_little
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x22"
    @serial_port.write command
  end

  def blue_on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x31"
    @serial_port.write command
  end

  def blue_little
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x32"
    @serial_port.write command
  end

  def mix_on
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x41"
    @serial_port.write command
  end

  def mix_little
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
    command = make_command @id, "\x40"
    @serial_port.write command
  end

  def adjust
    MXLogger.debug self.class.to_s + '--' + __method__.to_s
  end
end