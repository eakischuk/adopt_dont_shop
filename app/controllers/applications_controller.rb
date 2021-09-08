class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    if params[:search].present?
      @application = Application.find(params[:app_id])
      @search_pets = Pet.search(params[:search])
    else
      @application = Application.find(params[:app_id])
    end
  end

  def new
  end

  def create
    application = Application.new({
      name: params[:name],
      address: "#{params[:street]} #{params[:city]}, #{params[:state]} #{params[:zip]}",
      description: params[:description],
      status: "In Progress"
      })
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:app_id])
    if params[:pet].present?
      application.pets << Pet.find(params[:pet])
      redirect_to "/applications/#{application.id}"
    elsif params[:description].present?
      application.update({
                          description: params[:description],
                          status: "Pending"
                        })
      redirect_to "/applications/#{application.id}"
    end
  end
end
