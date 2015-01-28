require 'json'
require_relative  'mx_serial_port'
require_relative 'controller_server'
require_relative 'mx_logger'
require_relative 'protocol'
require_relative 'chair_controller'

class PC2
  def initialize
    @serial_port_list = []
    @threads = []
    @controller_server = ControllerServer.new
    @chair_controller = ChairController.new "\\\\.\\COM15"
    #init_serial_port
    init_socket_server
  end

  def init_socket_server
    @threads << Thread.new { @controller_server.start }
    @controller_server.add_observer self, :update_socket
  end

  def init_serial_port
      @serial_port_test = MXSerialPort.new "COM7"
      @serial_port_list.push @serial_port_test
      #@threads << Thread.new { serial_port_test.read_func }
      #@serial_port_test.write_on
      #@serial_port_test.write_off
      #@threads << Thread.new { @serial_port_test.write }
#  rescue
#      MXLogger.error "open serial port failed."
  end

  def wait
    @threads.each { |thr| thr.join }
  end

  def update_socket(result)
    MXLogger.debug "update socket #{result}"

    json_result = JSON.parse result
    MXLogger.debug json_result.to_s
    MXLogger.debug "action = #{json_result['action']}"
    case json_result['part']
    when 'door' then do_door json_result
    when 'chair' then do_chair json_result
    else
        MXLogger.error "unkown part"
    end

    MXLogger.debug "end update socket"
  end

  def do_chair(json_result)
    MXLogger.debug __method__.to_s
    case json_result['action']
      when 'start' then @chair_controller.start
      when 'stop' then @chair_controller.stop
      when 'headerup' then @chair_controller.header_up
      when 'headerdown' then @chair_controller.header_down
      when 'backup' then @chair_controller.back_up
      when 'backdown' then @chair_controller.back_down
      when 'hipup' then @chair_controller.hip_up
      when 'hipdown' then @chair_controller.hip_down
      when 'footup' then @chair_controller.foot_up
      when 'footdown' then @chair_controller.foot_down
      when 'waistup' then @chair_controller.waist_up
      when 'waistdown' then @chair_controller.waist_down
      when 'straight' then @chair_controller.straight
      when 'halflaydown' then @chair_controller.half_lay_down
      when 'laydown' then @chair_controller.lay_down
      else
        MXLogger.error "unknown action!"
    end
  end

  def do_door(json_result)
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

end

pc2 = PC2.new
pc2.wait

