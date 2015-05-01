class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /courses
  # GET /courses.json
  def index
    if current_user.nil?
      redirect_to user_session_path
      return
    end
    @courses = current_user.courses
    @permission = current_user
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    puts params[:id]
    @course = Course.find(params[:id])
    if current_user.has_role? :student or current_user.has_role? :instructor
      redirect_to course_teams_path(:course_id => @course.id)
    elsif current_user.has_role? :professor
      redirect_to all_assignments_path(params[:id])
    else
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = @current_user.user_id
    respond_to do |format|
      #instructor_exists
      if !course_name_exists? and professor_exist? and @course.save
        current_user.courses << @course
        format.html { redirect_to @course, notice: "Successfully added course #{@course.course_name}" }
        format.json { render :show, status: :created, location: @course }
      else
        if @course.errors[:message].empty?
          @course.errors.add(:course_name, "Course name exists")
        end
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if professor_exist? and @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
       params.require(:course).permit(:course_name, :user_id, :team_size, :description)
    end

    def course_name_exists?
      all_names = Course.pluck(:course_name)
      all_names.include? course_params[:course_name]
    end
    
    def professor_exist?
      if course_params[:user_id] == nil
        return true
      end
      all_users = User.all
      for user in all_users
        if user.has_role? :professor and user.user_id == course_params[:user_id].to_i
          return true
        end
      end
      return false
    end
end
