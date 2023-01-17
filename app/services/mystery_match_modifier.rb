class MysteryMatchModifier

  attr_reader :employee_id, :department_id, :action

  def initialize(employee_id:, department_id:, action:)
    @employee_id = employee_id
    @department_id = department_id
    @action = action
  end

  def call
    if action == 'add'
      add_mystery_lunch_partners(employee_id, department_id)
    elsif action == 'delete'
      remove_mystery_lunch_partners(employee_id, department_id)
    end
  end

  private

  def add_mystery_lunch_partners(employee_id, department_id)
    randomly_selected_mystery_partner_id = available_mystery_partners_by_department(department_id).pluck(:id).sample
    create_three_person_mystery_lunch_partners(randomly_selected_mystery_partner_id, employee_id, department_id)
  end

  def remove_mystery_lunch_partners(employee_id, department_id)
    mystery_partner = MysteryPartner
                          .where("employee1_id = ? OR employee2_id = ? OR employee3_id = ?", employee_id, employee_id, employee_id)
                          .where("created_at >= ?", Time.zone.now.beginning_of_month).last

    partner_ids = mystery_partner.slice(:employee1_id, :employee2_id, :employee3_id).map{|k,v| v}.compact
    remaining_partner_ids = partner_ids - [employee_id]
    if mystery_partner.present?
      if remaining_partner_ids.count == 2
        employee1 = Employee.find(remaining_partner_ids[0])
        employee2 = Employee.find(remaining_partner_ids[1])
        MysteryPartner.where(id: mystery_partner.id).update(employee1_id: employee1.id, employee2_id: employee2.id, employee3_id: nil, employee1_department_id: employee1.department_id, employee2_department_id: employee2.department_id, employee3_department_id: nil)
      elsif remaining_partner_ids.count == 1
        remaining_employee = Employee.find_by(id: remaining_partner_ids.first)
        available_mystery_partners = available_mystery_partners_by_department(remaining_employee.department_id) - mystery_partners_no_lunch_in_last_3_months(remaining_employee)
        randomly_selected_mystery_partner_id = available_mystery_partners.pluck(:id).sample
        create_three_person_mystery_lunch_partners(randomly_selected_mystery_partner_id, remaining_employee, remaining_employee.department_id)
        mystery_partner.destroy
      end
    end
  end

  def available_mystery_partners_by_department(department_id)
    MysteryPartner
        .where("employee3_id IS NULL")
        .where("employee1_department_id != ?", department_id)
        .where("employee2_department_id != ?", department_id)
        .where("created_at >= ?", Time.zone.now.beginning_of_month)
  end

  def mystery_partners_no_lunch_in_last_3_months(employee_id)
    MysteryPartner
        .where("employee1_id != ?", employee_id)
        .where("employee2_id != ?", employee_id)
        .where("employee3_id != ?", employee_id)
        .where("created_at >= ?", 3.months.ago.beginning_of_month)
  end

  def create_three_person_mystery_lunch_partners(mystery_partner_id, employee_id, department_id)
    MysteryPartner.where(id: mystery_partner_id).update(employee3_id: employee_id, employee3_department_id: department_id)
  end
end