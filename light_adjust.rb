require_relative 'light'
require_relative 'mx_logger'

class LightAdjust < Light
  def initialize(serial)
    super("\x11", serial)
    MXLogger.debug 'LightAdjust init'
  end
end