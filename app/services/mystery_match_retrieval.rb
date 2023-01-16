class MysteryMatchRetrieval

  attr_reader :department_id, :year, :month

  def initialize(department_id:, year: Time.now.year, month: Time.now.month)
    @department_id = department_id
    @year = year
    @month = month
  end

  def call
    retrieve_mystery_partners
  end

  private

  def retrieve_mystery_partners
    if department_id.present? && department_id != 0
      MysteryPartner.filter_by_department(department_id)
    else
      MysteryPartner.with_year_and_month(year, month)
    end
  end
end