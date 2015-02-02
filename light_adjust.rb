require_relative 'light'
require_relative 'mx_logger'

class LightAdjust < Light
  def initialize
    super("\x11", 'front-mid-light')
    MXLogger.debug 'LightAdjust init'
  end
end