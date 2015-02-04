require 'singleton'
require 'rubyserial'
require_relative 'global_config'
require_relative 'mx_logger'
require_relative 'part_factory'

class PartDistributor
  include Singleton

  def initialize
    @serial_hash = {}
    @serial_container = {}
    @part_container = {}
  end

  def init_parts
    config = GlobalConfig.instance
    config.working_serials_hash.each do |k, v|
      @serial_hash[k] = v['port']
      @serial_container[k] = Serial.new(v['port'], v['baudrate'].to_i)
      @part_container[k] = PartFactory.create(k, @serial_container[k])
    end
  end

  def get_part(part)
    @part_container[part]
  end

end