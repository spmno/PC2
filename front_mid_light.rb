require_relative 'light'

class FrontMidLight < Light
  def initialize
    super("\x11", "front-mid-light")
  end
end