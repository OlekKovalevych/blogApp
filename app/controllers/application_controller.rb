# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # i tutaj tę linijkę bym wyrzucił do poszczególnych kontrolerów
  before_action :authenticate_user!, only: %i[create new destroy]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sing_up, keys: %i[name surname is_admin])
  end
end
