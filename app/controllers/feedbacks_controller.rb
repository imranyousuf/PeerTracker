class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @course = Course.find(params[:course_id])
    @team = @course.teams.find(params[:team_id])
    @feedbacksgiven = @team.feedbacks.all.where(:giver_id => current_user.user_id)
    @feedbacksreceived = @team.feedbacks.all.where(:receiver_id => current_user.user_id)
    @user = current_user
    @feedbacks = Feedback.where(team_id: params[:team_id], giver_id: current_user.user_id)
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedbacks = []
    team = Team.find(params[:team_id])
    members = team.users.uniq
    for m in members
      f = Feedback.new
      f.giver_id = current_user.user_id
      f.receiver_id = m.user_id
      @feedbacks << f
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @team = Team.find(params[:team_id])
    if @team == nil
        flash[:notice] = "Could not find team"
        redirect_to course_path(params[:course_id])
    end
    @feedback = @team.feedbacks.new(feedback_params)
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to course_team_path(params[:course_id], params[:team_id]), notice: 'Feedback was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to course_team_path(params[:course_id], params[:team_id]), notice: 'Feedback was successfully updated.' }
      else
        format.html { render :edit }
        #format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:comments, :rating)
    end
end
