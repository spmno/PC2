require_relative 'power1'
require_relative 'mx_logger'

class Power12V1 < Power1
  def initialize(serial)
    super("\x72", serial)
  end
end
