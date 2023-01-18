class HomeController < ApplicationController
  def index
    @mystery_partners = retrieve_mystery_lunch_partners
  end

  private

  def retrieve_mystery_lunch_partners
    MysteryMatchRetrieval.new(department_id: params[:department_id], year: params[:year], month: params[:month]).call
  end
end
