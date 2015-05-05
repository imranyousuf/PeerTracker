class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user != nil 
      if current_user.has_role? :student
          redirect_to courses_path 
      elsif current_user.has_role? :professor 
        #@users = find_students_for_professor
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
    #flash[:notice] = "No Information can be shown about student!" 
    redirect_to users_path
  end

  # GET /users/new
  def new

   @courses = Course.where(:user_id => current_user.user_id)
   #flash[:notice] = params.inspect
   @course =  Course.find(params["course_id"])
   #user = User.new
   
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.where(:user_id => user_params[:user_id]).first
    @course = Course.find(params["user"]["course_id"])

    respond_to do |format|
      if @user and !@course.users.include? @user
        #if current_user.has_role? :professor
        #course = Course.where(:user_id => current_user.user_id).first
        @course.users << @user
        #end
        format.html { redirect_to @user, notice: 'User was successfully added.' }
        #format.json { render :show, status: :created, location: @user }
      else
        #@user = User.new
        if @course.users.include? @user
          flash.now[:error] = "User with ID: #{user_params[:user_id]} already enrolled in this class!"
        else
          flash.now[:error] = "User with ID: #{user_params[:user_id]} does not exist!"
        end
        format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    #respond_to do |format|
    #  if @user.update(user_params)
    #    format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @user }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @user.errors, status: :unprocessable_entity }
    #  end
    #end
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
      puts params[:course_id]
      course = Course.where(:user_id => current_user.user_id).where(:id => params[:course_id]).first
      puts course.inspect
      failed = User.import(params[:file], course)
      if !failed[0].empty?
        flash[:alert] = "Students/Instructors with these ID(s) not found: #{failed[0].join(', ')}"
      end
      if !failed[1].empty?
        flash[:error] = "Students/Instructors with these ID(s) already enrolled: #{failed[1].join(", ")}"
      end
      redirect_to users_path, notice: "User Data successfully uploaded"
    rescue
      redirect_to users_path, notice: "Invalid CSV file format" 
   end 
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params[:user]
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
