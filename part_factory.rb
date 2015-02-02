require_relative 'chair_controller'
require_relative 'front_mid_light'
require_relative 'mx_logger'
require_relative 'light_adjust'

class PartFactory
  def create(part)
    MXLogger.debug "PartFactory create #{part}."
    case part
      when 'chair' then ChairController.new
      when 'front-mid-light' then FrontMidLight.new
      when 'light-adjust' then LightAdjust.new
      else

    end
  end
end