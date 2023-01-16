class HomeController < ApplicationController
  def index
    # generate_mystery_lunch_partners
    @mystery_partners = retreive_mystery_lunch_partners
  end

  private

  def generate_mystery_lunch_partners
    MysteryMatchGenerator.new.call
  end

  def retreive_mystery_lunch_partners
    MysteryMatchRetrieval.new(department_id: params[:department_id].to_i, year: params[:year].to_i, month: params[:month].to_i).call
  end
end
