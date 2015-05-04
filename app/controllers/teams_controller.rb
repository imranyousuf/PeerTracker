class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    @teams = current_user.teams.where(:course_id => params[:course_id])
    @course = Course.find(params[:course_id])
    @course_id = @course.id
    @teams_params = getTeamNameInstructorandMembers
  end

  # GET /teams/1
  # GET /teams/1.json
  def show 
    @team = Team.find(params[:id])
    #@assignments = Assignment.where("course_id = ? and deadline > ?", @team.course_id, Time.zone.now) 
    if current_user.has_role? :student
      redirect_to course_team_assignments_path(:team_id => @team.id), :assignments => @assignments
    elsif current_user.has_role? :instructor
      # flash[:notice] = "not implemented for instructor yet!"
      redirect_to course_team_assignments_path(:team_id => @team.id), :assignments => @assignments
      return
    else
    end  
  end

  # GET /teams/new
  def new
    @team = Team.new
    @team_size = Course.find(params[:course_id]).team_size.to_i
    @student_sids = put_empty_members
  end

  # GET /teams/1/edit
  def edit
    @student_sids = put_curr_members
    @team_size = Course.find(params[:course_id]).team_size
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(name: team_params[:name], course_id: params[:course_id])
    @team.users << current_user
    @student_sids = put_empty_members
    error = ""
    @team_size = Course.find(params[:course_id]).team_size.to_i
    begin
      validate_team_members
    rescue Exception => e
      error = e.message
    end
    respond_to do |format|
      if @team.save and error.blank?
        format.html { redirect_to course_teams_path , notice: 'Team was successfully created.' }
        #format.json { render :show, status: :created, location: @team }
      else         
        if !error.blank?
          @team.errors.add(:validate, error)
          flash[:error] = error
        end
        if @team.errors[:message].empty? and error.blank?
          flash[:error] = "Team name exists"
        end
        format.html { render :new }
        #format.html { redirect_to new_course_team_path, notice: @team.errors[:name][0]}
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @student_sids = put_curr_members
    @team.users.clear
    @team_size = Course.find(params[:course_id]).team_size.to_i
    @team.users << current_user
    begin
      validate_team_members
    rescue Exception => e
      flash[:error] = e.message
      render :edit
      return
    end
    respond_to do |format|
      if @team.update(name: team_params[:name], course_id: params[:course_id])
        format.html { redirect_to course_teams_path, notice: 'Team was successfully updated.' }
        #format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        #format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    respond_to do |format|
      format.html { redirect_to course_teams_path, notice: 'Team was successfully removed.' }
    end
  end

  def import
    all_errors = Team.import(params[:file], params[:course_id], current_user)
    if all_errors.empty?
      redirect_to course_teams_path, notice: "Team Data successfully uploaded"
    else
      flash[:error] = all_errors.join(", ")
      redirect_to course_teams_path, alert: "Invalid CSV file format. Added Valid Data!" 
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :course_id)
    end

    def getTeamNameInstructorandMembers
      teams_params = []
      for team in @teams
        instructor = "None"
        users = []
        for user in team.users
          if user.has_role? :instructor
            instructor = user.full_name
          elsif user.has_role? :student
            users << user.full_name
          else

          end
        end
        teams_params << [team, instructor, users, team.id]
      end
      return teams_params
    end
    
    def validate_team_members
      for param_name in params.keys
        
        if /student_sid/.match(param_name)
          sid = params[param_name]
          user = User.where(user_id: sid.to_i).first
          course = Course.find(params[:course_id])
          if sid.nil? or sid.blank? or sid == "(Optional)"
          elsif  !course.users.include? user
            raise(ArgumentError, "Student with SID: #{sid} is not enrolled in this class")
          elsif @team.users.include? user
            raise(ArgumentError, "Student with SID: #{sid} is being added more than once!")
          else
            @team.users << user
          end
        end
      end
    end

    def put_empty_members
      {}
    end
    
    def put_curr_members
      student_sids = {}
      @team = Team.find(params[:id])
      i = 1
      for user in @team.users
        if user.has_role? :student
          student_sids[i] = user.user_id
          i += 1
        end
      end
      student_sids
    end
end
