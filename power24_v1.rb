require_relative 'power1'
require_relative 'mx_logger'

class Power24V1 < Power1
  def initialize(serial)
    super("\x73", serial)
  end
end
