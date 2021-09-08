class Admin::ApplicationPetsController < ApplicationController
  def update
    app_pet = Application.find(params[:app_id]).app_pet(params[:pet_id])
    app_pet.update({
      status: params[:status]
      })
      app_pet.save
    redirect_to "/admin/applications/#{params[:app_id]}"
  end
end
