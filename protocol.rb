# encoding:ascii-8bit
require 'json'
require_relative 'mx_logger'

class Protocol
  HEADER = ["\xCF", "\xCF", "\x00", "\x00"].join
  TAIL = ["\xDD", "\xDD"].join

  def make_command(id, command)
    HEADER + id + command + TAIL
  end

  def host_to_controller
    MXLogger.debug @json_hash.to_s

    case @json_hash['part']
      when 'door' then make_door_command
      when 'light' then make_light_command
      when 'lock' then make_lock_command
      when 'chair' then make_chair_command
      else
        MXLogger.error "unknown part!!!!!!!!!!!!!!!!!!!!!"
    end
  end

  def make_door_command
    MXLogger.debug __method__.to_s
    if json_result['action'] == 'open'
      MXLogger.debug "receive open command"
      @serial_port_test.write_on
    elsif json_result['action'] == 'close'
      MXLogger.debug "receive close command"
      @serial_port_test.write_off
    else
      MXLogger.debug "unknown command"
    end
  end

  def make_light_command
    MXLogger.debug "method:" + __method__.to_s
    if json_result['action'] == 'on'

    end
  end

  def make_lock_command

  end

  def make_chair_command

  end

  def controller_to_host(content)

  end
end