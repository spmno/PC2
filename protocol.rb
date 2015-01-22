require 'json'

class Protocol
  def initialize content
    @content = content
    #@state
  end

  def send_inquire_frame
    command_hash = JSON.parse @content
    command_array = []
    command_array.push 0xCF, 0xCF
    command_array.push 0x00, 0x01
    case command_hash['part']
      when 'door'
        command_array.push 0x1
    end
    case command_hash['action']
      when 'open'
        command_array
    end
    command_array
  end

  def host_to_controller
    command_hash = JSON.parse @content
    command_array = []
    command_array.push 0xCF, 0xCF
    case command_hash['part']
      when 'door'
        command_array.push 0x1
    end

  end

  def controller_to_host(content)

  end
end