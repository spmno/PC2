require_relative 'lock'

class FrontDoorLock < Lock
  def initialize
    super("\x81", "front-door-look")
  end
end