class MysteryMatchGenerator

  def initialize
  end

  def call
    generate_mystery_lunch_partners
  end

  private

  def generate_mystery_lunch_partners
    employees = Employee.all
    mystery_lunch_partners = []
    existing_partner = [] # employees whose match already made
    departments = employees.map(&:department_id).uniq
    employees_by_department = {} # Hash to store employees based on departments
    departments.each do |d|
      employees_by_department[d] = employees.select { |e| e.department_id == d }
    end

    shuffled_employees = employees.shuffle # randomize the employee
    shuffled_employees.each do |employee|
      next if existing_partner.include?(employee[:id])

      available_employees = employees_by_department.reject do |department_id, e|
        department_id == employee['department_id'] # exclude employees from the same department
      end

      available_employees.each do |department_id, e|
        e.reject! do |possible_partner|
          possible_partner == employee || # exclude the current employee
              existing_partner.include?(possible_partner[:id]) # exclude the partner if has existing match with another partner
        end
      end

      # randomly select an available employee
      partner = available_employees.values.flatten.sample


      # add the partnership to the mystery_lunch_partners
      if partner.present? && !existing_partner.include?(partner[:id])
        mystery_lunch_partners.append([employee[:id], partner[:id]])
        existing_partner.append(employee[:id])
        existing_partner.append(partner[:id])
      end
    end

    mystery_lunch_partners.each do |mystery_lunch_partner|
      MysteryPartner.create(employee1_id: mystery_lunch_partner[0], employee2_id: mystery_lunch_partner[1], employee1_department_id: employees.find { |employee| employee.id == mystery_lunch_partner[0] }.department_id, employee2_department_id: employees.find { |employee| employee.id == mystery_lunch_partner[1] }.department_id)
    end
  end
end