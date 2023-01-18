class MysteryMatchRetrieval

  attr_reader :department_id, :year, :month

  def initialize(department_id:, year:, month:)
    @department_id = department_id
    @year = year
    @month = month
  end

  def call
    retrieve_mystery_partners
  end

  private

  def retrieve_mystery_partners
    if department_id.present? && year.present? && month.present?
      MysteryPartner.filter_by_department(department_id.to_i).with_year_and_month(year.to_i, month.to_i)
    elsif department_id.present?
      MysteryPartner.filter_by_department(department_id.to_i)
    else
      MysteryPartner.with_year_and_month(year || Time.now.year, month || Time.now.month)
    end
  end
end