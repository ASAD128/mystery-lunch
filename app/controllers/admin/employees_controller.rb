module Admin
  class EmployeesController < Admin::BaseController
    before_action :set_admin_employee, only: [:show, :edit, :update, :destroy]

    # GET /admin/employees
    def index
      @admin_employees = Employee.all
    end

    # GET /admin/employees/1
    def show
    end

    # GET /admin/employees/new
    def new
      @admin_employee = Employee.new
    end

    # GET /admin/employees/1/edit
    def edit
    end

    # POST /admin/employees
    def create
      @admin_employee = Employee.new(admin_employee_params)

      if @admin_employee.save
        add_new_employee_existing_mystery_lunch
        redirect_to admin_employee_url(@admin_employee), notice: 'Employee was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/employees/1
    def update
      if @admin_employee.update(admin_employee_params)
        redirect_to admin_employee_url(@admin_employee), notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/employees/1
    def destroy
      @admin_employee.destroy
      remove_employee_from_coming_mystery_lunch
      redirect_to admin_employees_url, notice: 'Employee was successfully destroyed.'
    end

    private

    def set_admin_employee
      @admin_employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_employee_params
      params.fetch(:employee, {}).permit(:name, :department_id, :image)
    end

    def add_new_employee_existing_mystery_lunch
      if MysteryPartner.count > 0
        MysteryMatchModifier.new(employee_id: @admin_employee.id, department_id: @admin_employee.id, action: 'add').call
      end
    end

    def remove_employee_from_coming_mystery_lunch
      if MysteryPartner.count > 0
        MysteryMatchModifier.new(employee_id: @admin_employee.id, department_id: @admin_employee.id, action: 'delete').call
      end
    end
  end
end
