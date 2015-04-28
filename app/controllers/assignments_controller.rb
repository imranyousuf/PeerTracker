class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments.all
    @permission = current_user.has_role?(:instructor) || current_user.has_role?(:professor)
    @team = Team.find(params[:team_id])
    @names = []
    for user in @team.users
      if user.has_role? :student
        @names << user
      end
    end
  end

  def professorindex
    @course = Course.find(params[:id])
    @assignments = @course.assignments.all
    @permission = current_user.has_role?(:instructor) || current_user.has_role?(:professor)
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    redirect_to course_team_assignment_feedbacks_path(:course_id => params[:course_id], :team_id => params[:team_id], :assignment_id => params[:id])
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:assignment_id])
    @course = Course.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @course = Course.find(params[:id])
    if @assignment.assignment_name == ""
      flash[:error] = "Assignment Name cannot be nil"
      return redirect_to :action => "new"
    end
    if @assignment.deadline < Time.now
      flash[:error] = "Assignment cannot be due in the past"
      return redirect_to :action => "new"
    end
    respond_to do |format|
      if @assignment.save
        @course.assignments << @assignment
        format.html { redirect_to all_assignments_path, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to all_assignments_path, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:assignment_name, :course, :deadline)
    end
end
