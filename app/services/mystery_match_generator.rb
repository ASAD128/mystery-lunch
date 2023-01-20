class MysteryMatchGenerator

  attr_reader :employees, :departments, :last_three_months_partners, :employees_hash

  def initialize()
    @employees = Employee.all
    @departments = Department.all
    @last_three_months_partners = last_three_months_partners
    @employees_hash = employees_hash
  end

  def call
    generate_mystery_lunch_partners
  end

  private

  def generate_mystery_lunch_partners
    current_mystery_lunch_partners = [] # current month mystery partner pairs e.g [[1,2], [3,4]]
    employees_with_match_found = [] # employees ids array when their match is found [1,2,3,4]

    employees_by_department = {} # Hash to store employees based on departments
    departments.each do |department|
      employees_by_department[department.id] = employees.select { |e| e.department_id == department.id }
    end

    last_three_months_partners_hash = {} # Hash to store last 3 previous months lunch partners
    last_three_months_partners.each_with_index do |last_three_months_partner, i|
      last_three_months_partners_hash[last_three_months_partner] = i
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
              employees_with_match_found.include?(possible_partner[:id]) || # exclude the possible_partner if found out the match already
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


    if employees.length.odd?

      remaining_employee = (employees.pluck(:id) - employees_with_match_found).first
      remaining_employee_department = employees.select { |e| e.id == remaining_employee }.first.department_id


      available_partners = current_mystery_lunch_partners.select do |partner|
        employees_hash[partner[0]][:department_id] != remaining_employee_department &&
        employees_hash[partner[1]][:department_id] != remaining_employee_department &&
        last_three_months_partners_hash.try(:key?, [partner[0], remaining_employee]) == false &&
        last_three_months_partners_hash.try(:key?, [remaining_employee, partner[1]]) == false
      end

      new_partner = available_partners.first

      current_mystery_lunch_partners.delete(new_partner)

      current_mystery_lunch_partners.append([new_partner[0], new_partner[1], remaining_employee])
    end

    insert_mystery_lunch_partners_into_db(current_mystery_lunch_partners)
  end

  def insert_mystery_lunch_partners_into_db(current_mystery_lunch_partners)
    current_mystery_lunch_partners.each do |mystery_lunch_partner|
      MysteryPartner.create(employee1_id: mystery_lunch_partner[0],
                            employee2_id: mystery_lunch_partner[1],
                            employee3_id: mystery_lunch_partner[2],
                            employee1_department_id: employees_hash[mystery_lunch_partner[0]][:department_id],
                            employee2_department_id: employees_hash[mystery_lunch_partner[1]][:department_id],
                            employee3_department_id: employees_hash.try(:[], mystery_lunch_partner[2]).try(:[], :department_id))
    end
  end

  def employees_hash
    employees_hash = {} # Hash to store department of each employee
    employees.each do |employee|
      employees_hash[employee.id] = { department_id: employee.department_id }
    end
    return employees_hash
  end

  def last_three_months_partners
    last_three_months_pairs = MysteryPartner.where("created_at >= ?", 3.months.ago.beginning_of_month).where("employee3_id IS NULL").pluck(:employee1_id, :employee2_id)
    last_three_months_triplets = MysteryPartner.where("created_at >= ?", 3.months.ago.beginning_of_month).pluck(:employee1_id, :employee2_id, :employee3_id)
    last_three_months_triplets_combinations = convert_triplet_into_pairs(last_three_months_triplets)
    last_three_months_partners = last_three_months_pairs + last_three_months_triplets_combinations
    return last_three_months_partners

  end

  def convert_triplet_into_pairs(arr)
    # arr = [[1, 2, 3], [4, 5, 6]] would return [[1, 2], [2, 3], [1, 3], [4, 5], [5, 6], [4, 6]] complexity O(n)
    combinations = []
    arr.each do |sub_arr|
      sub_arr_combinations = sub_arr.combination(2).to_a
      combinations.concat(sub_arr_combinations)
    end
    return combinations
  end
end
