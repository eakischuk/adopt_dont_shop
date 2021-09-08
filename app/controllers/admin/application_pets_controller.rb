class Admin::ApplicationPetsController < ApplicationController
  def update
    app_pet = Application.find(params[:app_id]).app_pet(params[:pet_id])
    app_pet.update({
      status: "Approved"
      })
      app_pet.save
    redirect_to "/admin/applications/#{params[:app_id]}?app_pets_id=#{app_pet.id}"
  end
end
