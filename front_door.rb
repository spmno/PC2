require_relative 'door'

class FrontDoor < Door
  def initialize
    super("\x32", "front-door")
  end
end