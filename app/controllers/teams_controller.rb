class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
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
      params[:team]
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
end
