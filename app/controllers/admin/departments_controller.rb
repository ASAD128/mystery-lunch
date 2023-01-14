class Admin::DepartmentsController < ApplicationController
  before_action :set_admin_department, only: [:show, :edit, :update, :destroy]

  # GET /admin/departments
  def index
    @admin_departments = Department.all
  end

  # GET /admin/departments/1
  def show
  end

  # GET /admin/departments/new
  def new
    @admin_department = Department.new
  end

  # GET /admin/departments/1/edit
  def edit
  end

  # POST /admin/departments
  def create
    @admin_department = Department.new(admin_department_params)

    if @admin_department.save
      redirect_to admin_department_url(@admin_department), notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/departments/1
  def update
    if @admin_department.update(admin_department_params)
      redirect_to admin_department_url(@admin_department), notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/departments/1
  def destroy
    @admin_department.destroy
    redirect_to admin_departments_url, notice: 'Department was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_department
      @admin_department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_department_params
      params.fetch(:admin_department, {})
    end
end
