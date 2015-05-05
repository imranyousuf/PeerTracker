class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user != nil 
      if current_user.has_role? :student
          redirect_to courses_path 
      elsif current_user.has_role? :professor 
        @courses = Course.where(:user_id => current_user.user_id)
      elsif current_user.has_role? :instructor
        @users = find_students_for_instructor 
        @courses = current_user.courses
      end
    else
      redirect_to new_user_session_path
    end
  
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to users_path
  end

  # GET /users/new
  def new
   @courses = Course.where(:user_id => current_user.user_id)
   @course =  Course.find(params["course_id"])   
  end

  # GET /users/1/edit
  def edit
    redirect_to users_path
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.where(:user_id => user_params[:user_id]).first
    @course = Course.find(params["user"]["course_id"])
    respond_to do |format|
      if @user and !@course.users.include? @user
        @course.users << @user
        format.html { redirect_to @user, notice: 'User was successfully added.' }
      else
        if @course.users.include? @user
          flash.now[:error] = "User with ID: #{user_params[:user_id]} already enrolled in this class!"
        else
          flash.now[:error] = "User with ID: #{user_params[:user_id]} does not exist!"
        end
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    redirect_to users_path
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    course = Course.find(params[:course_id])
    course.users.delete(@user)
    respond_to do |format|
      format.html { redirect_to users_url, notice: "#{@user.full_name} was successfully removed from this course." }
      format.json { head :no_content }
    end
  end

  def import
    begin
      course = Course.where(:user_id => current_user.user_id).first
      failed = User.import(params[:file], course)
      if !failed[0].empty?
        flash[:alert] = "Students/Instructors with these ID(s) not found: #{failed[0].join(', ')}"
      end
      if !failed[1].empty?
        flash[:error] = "Students/Instructors with these ID(s) already enrolled: #{failed[1].join(", ")}"
      end
      redirect_to users_path, notice: "User Data successfully uploaded"
    rescue
      redirect_to users_path, error: "Invalid CSV file format" 
   end 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :user_id, :email, :password, :sign_in_count)
    end


    def find_students_for_instructor
      users = []
      @instructor = current_user
      @teams = @instructor.teams
      for team in @teams
        for user in team.users
          if user.has_role? :student
            users << user
          end
        end
      end
      users
    end
end
