require 'singleton'
require_relative 'global_config'
require_relative 'mx_logger'

class SerialDistributor
  include Singleton

  def initialize
    @serial_hash = {}
    @serial_container = {}
  end

  def init_serials
    config = GlobalConfig.instance
    config.working_serials_hash.each do |k, v|
      @serial_hash[k] = v['port']
      @serial_container[k] = Serial.new(v['port'], "115200".to_i)
    end
  end

  def get_serial(part)
    @serial_container[part]
  end

end