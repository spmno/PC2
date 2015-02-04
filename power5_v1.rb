require_relative 'power1'
require_relative 'mx_logger'

class Power5V1 < Power1
  def initialize(serial)
    super("\x71", serial)
  end
end