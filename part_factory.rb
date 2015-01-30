require_relative 'chair_controller'
require_relative 'front_mid_light'
require_relative 'mx_logger'

class PartFactory
  def create(part)
    MXLogger.debug "PartFactory create #{part}."
    case part
      when 'chair' then ChairController.new
      when 'front-mid-light' then FrontMidLight.new
    end
  end
end