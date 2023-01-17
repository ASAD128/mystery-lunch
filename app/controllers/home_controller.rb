class HomeController < ApplicationController
  def index
    @mystery_partners = retrieve_mystery_lunch_partners
  end

  private

  def retrieve_mystery_lunch_partners
    MysteryMatchRetrieval.new(department_id: params[:department_id].to_i, year: params[:year].to_i, month: params[:month].to_i).call
  end
end
