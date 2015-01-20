require 'json'

class Protocol
  def initialize
    @state
  end

  def host_to_controller(content)
    command_hash = JSON.parse content

  end

  def controller_to_host(content)

  end
end