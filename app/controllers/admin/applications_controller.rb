class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
    if params[:app_pets_id].present?
      @app_pets = ApplicationPet.find(params[:app_pets_id])

    end
  end
end
