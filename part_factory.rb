require_relative 'chair_controller'
require_relative 'front_mid_light'
require_relative 'mx_logger'
require_relative 'light_adjust'
require_relative 'power5_v1'
require_relative 'power12_v1'
require_relative 'power24_v1'
require_relative 'iris_door'

class PartFactory
  def self.create(part, serial)
    MXLogger.debug "PartFactory create #{part}."
    case part
      when 'chair' then ChairController.new serial
      when 'front-mid-light' then FrontMidLight.new serial
      when 'light-adjust' then LightAdjust.new serial
      when 'power-5v-1' then Power5V1.new serial
      when 'power-12v-1' then Power12V1.new serial
      when 'power-24v-1' then Power24V1.new serial
      when 'iris-door' then IrisDoor.new serial
      else

    end
  end
end