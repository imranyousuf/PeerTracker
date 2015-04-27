class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /teams
  # GET /teams.json
  def index
    @teams = current_user.teams.where(:course_id => params[:course_id]).uniq
    @course = Course.find(params[:course_id])
    @course_id = @course.id
    @teams_params = getTeamNameInstructorandMembers
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @assignments = Assignment.where("course_id = ? and deadline > ?", @team.course_id, Time.zone.now)
    puts @assignments
  end

  # GET /teams/new
  def new
    @team = Team.new
    @student_sids = put_empty_members
  end

  # GET /teams/1/edit
  def edit
    @student_sids = put_curr_members
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(name: team_params[:name], course_id: params[:course_id])
    @team.users << current_user
    @student_sids = put_empty_members
    begin
      validate_team_members
    rescue Exception => e
      flash[:error] = e.message
      render :new
      return
    end
    respond_to do |format|
      if @team.save
        format.html { redirect_to course_teams_path , notice: 'Team was successfully created.' }
        #format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        #format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @student_sids = put_curr_members
    @team.users.clear
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
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    begin
      Team.import(params[:file])
      redirect_to teams_path, notice: "Team Data successfully uploaded"
    rescue
      redirect_to teams_path, notice: "Invalid CSV file format" 
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
            instructor = user.name
          elsif user.has_role? :student
            users << user.name
          else

          end
        end
        teams_params << [team.name, instructor, users, team.id]
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
