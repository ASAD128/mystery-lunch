class MysteryMatchGenerator

  def initialize
  end

  def call
    generate_mystery_lunch_partners
  end

  private

  def generate_mystery_lunch_partners
    employees = Employee.all

    last_three_months_partners_hash = {}
    last_three_months_partners = MysteryPartner.where("created_at >= ?", 3.months.ago.beginning_of_month).pluck(:employee1_id, :employee2_id)

    last_three_months_partners.each_with_index { |last_three_months_partner, i| last_three_months_partners_hash[last_three_months_partner] = i }


    current_mystery_lunch_partners = [] # current month mystery partner
    employees_with_match_found = [] # employees whose match already made
    departments = employees.map(&:department_id).uniq

    employees_by_department = {} # Hash to store employees based on departments
    departments.each do |d|
      employees_by_department[d] = employees.select { |e| e.department_id == d }
    end

    shuffled_employees = employees.shuffle # randomize the employee

    shuffled_employees.each do |employee|
      next if employees_with_match_found.include?(employee[:id])

      available_employees = employees_by_department.reject do |department_id, e|
        department_id == employee['department_id'] # exclude employees from the same department
      end

      available_employees.each do |department_id, e|
        e.reject! do |possible_partner|

          possible_partner == employee || # exclude the current employee
              employees_with_match_found.include?(possible_partner[:id]) || # exclude the partner if has existing match with another partner
              last_three_months_partners_hash.try(:key?, [possible_partner[:id], employee[:id]]).present? ||
              last_three_months_partners_hash.try(:key?, [employee[:id], possible_partner[:id]]).present?
        end
      end

      # randomly select an available employee
      partner = available_employees.values.flatten.sample

      # add the partnership to the mystery_lunch_partners
      if partner.present?
        current_mystery_lunch_partners.append([employee[:id], partner[:id]])
        employees_with_match_found.push(employee[:id], partner[:id])
      end
    end



    current_mystery_lunch_partners.each do |mystery_lunch_partner|
      MysteryPartner.create(employee1_id: mystery_lunch_partner[0], employee2_id: mystery_lunch_partner[1], employee1_department_id: employees.find { |employee| employee.id == mystery_lunch_partner[0] }.department_id, employee2_department_id: employees.find { |employee| employee.id == mystery_lunch_partner[1] }.department_id)
    end
  end
end