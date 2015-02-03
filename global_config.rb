require 'singleton'
require 'json'
require_relative 'mx_logger'

class GlobalConfig
  include Singleton
  attr_accessor :serials_hash, :working_serials_hash

  def initialize
    file = File.open("serial_config.json", "r")
    content = file.read(file.size)
    @serials_hash =  JSON.parse content
    @working_serials_hash = @serials_hash.select {|k, v| v["status"] == "on"}
    @working_serials_hash.map {|k, v| MXLogger.debug "part: #{k}, port:#{v['port']}, baudrate:#{v['baudrate']} "}
    file.close
  end

end