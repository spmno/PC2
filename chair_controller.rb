require 'rubyserial'
require_relative 'mx_logger'
require_relative 'part_distributor'

class ChairController
  def initialize(serial)
    @serial_port = serial
  end

  def execute(command)
    MXLogger.debug __method__.to_s
    case command
      when 'start' then start
      when 'stop' then stop
      when 'header-up' then header_up
      when 'header-down' then header_down
      when 'back-up' then back_up
      when 'back-down' then back_down
      when 'hip-up' then hip_up
      when 'hip-down' then hip_down
      when 'foot-up' then foot_up
      when 'foot-down' then foot_down
      when 'waist-up' then waist_up
      when 'waist-down' then waist_down
      when 'straight' then straight
      when 'half-lay-down' then half_lay_down
      when 'lay-down' then lay_down
      else
        MXLogger.error 'unknown action!'
    end
  end

  def start
    MXLogger.debug __method__.to_s
    begin
    15.times do
      @serial_port.write "\x01"
    end
    rescue
      MXLogger.debug 'serial port error'
      #raise "serial error"
    end
  end

  def send_control_command(command)
    MXLogger.debug __method__.to_s
    10.times do
      @serial_port.write command
    end
  end

  def header_up
    MXLogger.debug __method__.to_s
    send_control_command "\x45"
  end

  def header_down
    MXLogger.debug __method__.to_s
    send_control_command "\x47"
  end

  def back_up
    MXLogger.debug __method__.to_s
    send_control_command "\x96"
  end

  def back_down
    MXLogger.debug __method__.to_s
    send_control_command "\x98"
  end

  def hip_up
    MXLogger.debug __method__.to_s
    send_control_command "\xA5"
  end

  def hip_down
    MXLogger.debug __method__.to_s
    send_control_command "\xA7"
  end

  def foot_up
    MXLogger.debug __method__.to_s
    send_control_command "\xB6"
  end

  def foot_down
    MXLogger.debug __method__.to_s
    send_control_command "\xB8"
  end

  def waist_up
    MXLogger.debug __method__.to_s
    send_control_command "\xD5"
  end

  def waist_down
    MXLogger.debug __method__.to_s
    send_control_command "\xD7"
  end

  def stop
    MXLogger.debug __method__.to_s
    send_control_command "\x00"
  end

  def straight
    MXLogger.debug __method__.to_s
    send_control_command "\x0E"
  end

  def half_lay_down
    MXLogger.debug __method__.to_s
    send_control_command "\x0F"
  end

  def lay_down
    MXLogger.debug __method__.to_s
    send_control_command "\x10"
  end

end