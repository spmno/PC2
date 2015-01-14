require 'json'

class Protocol
  def host_to_controller(content)
    command_hash = JSON.parser content

  end

  def controller_to_host(content)

  end
end