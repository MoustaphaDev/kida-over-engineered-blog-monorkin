# frozen_string_literal: true

module ColorSchemeHelper
  LIGHT_COLOR_SCHEME_CLASS = 'color-scheme--light'
  DARK_COLOR_SCHEME_CLASS = 'color-scheme--dark'

  def current_color_scheme_class
    color_scheme_class_for(current_color_scheme)
  end

  def color_scheme_class_for(scheme)
    case scheme&.to_s&.downcase&.to_sym
    when :light then light_color_scheme_class
    when :dark then dark_color_scheme_class
    end
  end

  def light_color_scheme_class
    LIGHT_COLOR_SCHEME_CLASS
  end

  def dark_color_scheme_class
    DARK_COLOR_SCHEME_CLASS
  end

  def current_color_scheme
    return if cookies[:color_scheme].blank?

    scheme = cookies[:color_scheme]&.to_s&.downcase&.to_sym
    return unless %i[light dark auto].include?(scheme)

    scheme
  end
end
