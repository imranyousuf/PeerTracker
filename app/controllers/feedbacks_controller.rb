class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @course = Course.find(params[:course_id])
    @team = @course.teams.find(params[:team_id])
    @assignment = Assignment.find(params[:assignment_id])
    @feedbacksgiven = @team.feedbacks.all.where(:giver_id => current_user.user_id)
    @feedbacksreceived = @team.feedbacks.all.where(:receiver_id => current_user.user_id)
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedbacks = []
    @course = Course.find(params[:course_id])
    team = @course.teams.find(params[:team_id])
    @members = team.users.uniq
    @user = current_user
    @users = []
    for m in @members
      if m.user_id != current_user.user_id and m.has_role? :student
        f = Feedback.new
        f.giver_id = current_user.user_id
        f.receiver_id = m.user_id
        @feedbacks << f
        @users << m
      end
    end
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
    @receiver = User.where(:user_id => @feedback.receiver_id).first
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @team = Team.find(params[:team_id])
    if @team == nil
        flash[:error] = "Could not find team"
        return redirect_to course_path(params[:course_id])
    end
    @feedback = @team.feedbacks.new(feedback_params)
    @receiver_id= params[:user][:user_id]
    @feedback.receiver_id = @receiver_id
    if check_params(@feedback, @team)
      flash[:error] = "Wrong arguments"
      return redirect_to :action => "new"
    end
 
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to course_team_assignment_feedbacks_path(params[:course_id], params[:team_id], params[:assignment_id], params[:id]), notice: 'Feedback was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def check_params(feedback, team)
    check1 = feedback.comments.nil?
    check2 = !(feedback.rating.is_a? Integer) or feedback.rating < 0 or feedback.rating > 100
    check3 = team.users.where(:user_id => feedback.receiver_id).blank?
    if (check1 or check2 or check3)
      return true
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    @team = Team.find(params[:team_id])
    @feedbackcheck = Feedback.create(feedback_params)
    if check_params(@feedbackcheck, @team)
      flash[:error] = "Wrong arguments"
      return redirect_to :action => 'edit'
    end 
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to course_team_assignment_feedbacks_path(params[:course_id], params[:team_id], params[:assignment_id]), notice: 'Feedback was successfully updated.' }
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
      params.require(:feedback).permit(:comments, :rating, :receiver_id, :giver_id)
    end
end
