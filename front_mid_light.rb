require_relative 'light'

class FrontMidLight < Light
  def initialize(serial)
    super("\x11", serial)
  end
end