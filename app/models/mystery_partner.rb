class MysteryPartner < ApplicationRecord

  scope :with_year_and_month, ->(year, month) {
    where("date_part('year', created_at) = ? AND date_part('month', created_at) = ?", year, month)
  }

  scope :filter_by_department, -> (department_id) { where "employee1_department_id = ? or employee2_department_id = ?", department_id, department_id }
end
