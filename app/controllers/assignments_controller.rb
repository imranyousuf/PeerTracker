class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

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
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments.all
    @permission = current_user.has_role?(:instructor) || current_user.has_role?(:professor)
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    redirect_to course_team_assignment_feedbacks_path(:course_id => params[:course_id], :team_id => params[:team_id], :assignment_id => params[:id])
  end

 def professorshow
    @permission = current_user.has_role?(:instructor) || current_user.has_role?(:professor)
    @assignment = Assignment.find(params[:id])
    @teams = current_user.teams.where(:course_id => params[:course_id]) if current_user.has_role? (:instructor)
    @teams = Course.find(params[:course_id]).teams if current_user.has_role? (:professor)
    @teams_info = []
    for team in @teams
      problem = 2
      students = {}
      min_score = 1000
      num_members = 0
      feedbacks_received = 0
      for student in team.users
        flag = 2
        if student.has_role? :student
          num_members += 1
          average_rating = student.average_rating(@assignment)
          if average_rating != "N/A"
            feedbacks_received += 1
            if average_rating.to_i < 20*(1-0.15)
              flag -= 1
            end
            if average_rating.to_i < 20*(1-0.35)
              flag -= 1
            end
            if flag < 2
              problem = flag
            end
            if average_rating.to_i < min_score
              min_score = average_rating.to_i
            end
          end
          students[student] = [ average_rating, flag ]
        end
      end
      if num_members == 0
        num_members = 1
      end
      @teams_info << [team, problem, min_score, students, feedbacks_received/(num_members.to_f * num_members.to_f)]
    end
    @teams_info = @teams_info.sort_by { |e| e[0].name }  if params[:sort_by].present? and params[:sort_by] == "team name"
    @teams_info = @teams_info.sort_by { |e| e[0].group_number }  if params[:sort_by].present? and params[:sort_by] == "group number"
    @teams_info = @teams_info.sort_by { |e| e[2] }  if params[:sort_by].present? and params[:sort_by] == "min score"
    return @teams_info

  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @course = Course.find(params[:course_id])
    if @assignment.assignment_name == ""
      flash[:error] = "Assignment Name cannot be nil"
      return redirect_to :action => "new"
    elsif @course.assignments.map(&:assignment_name).include? @assignment.assignment_name
       flash[:error] = "Assignment Name exists"
       return redirect_to :action => "new"
    elsif @assignment.deadline < Time.zone.now
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
    if assignment_params[:assignment_name] == ""
      flash[:error] = "Assignment must have a name"
      return redirect_to :action => "edit"
    end
    if assignment_params[:deadline] and (assignment_params[:deadline] < Time.zone.now)
      flash[:error] = "Assignment cannot be due in the past"
      return redirect_to :action => "edit"
    end

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
    if current_user.has_role?(:instructor) || current_user.has_role?(:professor)
      set_assignment
      @assignment.destroy

      respond_to do |format|
        flash[:notice] = 'Assignment was successfully destroyed.'
        format.html { redirect_to :action => "professorindex", notice: 'Assignment was successfully destroyed.' }
        #format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:assignment_name, :course, :deadline, :instructions, :description)
    end
end
