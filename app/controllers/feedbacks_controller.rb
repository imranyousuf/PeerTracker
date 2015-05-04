class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @course = Course.find(params[:course_id])
    @team = @course.teams.find(params[:team_id])
    @assignment = Assignment.find(params[:assignment_id])
    puts "PLS..."
    puts @assignment.inspect
    @feedbacksgiven = @assignment.feedbacks.all.where(:giver_id => current_user.user_id)
    puts @feedbacksgiven.inspect
    @feedbacksreceived = @assignment.feedbacks.all.where(:receiver_id => current_user.user_id)
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
    @feedbacks = []
    @course = Course.find(params[:course_id])
    team = @course.teams.find(params[:team_id])
    @members = team.users.uniq
    @user = current_user
    @users = []
    for m in @members
      if m.has_role? :student
        f = Feedback.new
        f.giver_id = current_user.user_id
        f.receiver_id = m.user_id
        @feedbacks << f
        @users << m
      end
    end
    assignment = Assignment.find(params[:assignment_id])
    @instructions = assignment.instructions
    if assignment.deadline < Time.zone.now
      flash[:error] = "Cannot give new feedback after assignment deadline"
      redirect_to :action => "index"
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
    assignment = Assignment.find(params[:assignment_id])
    @instructions = assignment.instructions
    if @feedback.assignment.deadline < Time.zone.now
      flash[:error] = "Cannot edit feedback after assignment deadline"
      redirect_to :action => "index"
    end
    @receiver = User.where(:user_id => @feedback.receiver_id).first
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @team = Team.where(:id => params[:team_id]).first
    if @team == nil
        flash[:error] = "Could not find team"
        return redirect_to :action => "index"
    end
    @feedback = @team.feedbacks.new(feedback_params)
    @receiver_id= params[:user][:user_id]
    @feedback.receiver_id = @receiver_id
    if check_params(@feedback, @team)
      flash[:error] = "Wrong arguments"
      return redirect_to :action => "new"
    end
    assignment = Assignment.find(params[:assignment_id])
    @instructions = assignment.instructions
    respond_to do |format|
      if @feedback.save
        assignment.feedbacks << @feedback
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
    assignment = Assignment.find(params[:assignment_id])
    @instructions = assignment.instructions
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
