require 'rubyserial'
require_relative 'mx_logger'
class ChairController
  def initialize(port)
    MXLogger.debug "port = #{port}"
    @serial_port = Serial.new(port, "9600".to_i)
  end

  def start
    MXLogger.debug __method__.to_s
    15.times do
      @serial_port.write "\x01"
    end
  end

  def send_control_command(command)
    MXLogger.debug __method__.to_s
    6.times do
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
    send_control_command "\xB5"
  end

  def foot_down
    MXLogger.debug __method__.to_s
    send_control_command "\xB7"
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
    @serial_port.write "\x0E"
  end

  def half_lay_down
    MXLogger.debug __method__.to_s
    @serial_port.write "\x0F"
  end

  def lay_down
    MXLogger.debug __method__.to_s
    @serial_port.write "\x10"
  end

end