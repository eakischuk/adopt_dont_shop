class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_desc_alpha
    @pending = Shelter.with_pending_apps
  end
end
