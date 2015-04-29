class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user != nil 
      if current_user.has_role? :student
          redirect_to courses_path 
      elsif current_user.has_role? :professor 
        @users = find_students_for_professor
      elsif current_user.has_role? :instructor
        @users = find_students_for_instructor 
      else
        @users = User.all
      end 
    else
      redirect_to new_user_session_path
    end
  
  end

  # GET /users/1
  # GET /users/1.json
  def show
    flash[:notice] = "No Information can be shown about student!" 
    redirect_to users_path
  end

  # GET /users/new
  def new
    #if current_user.has_role? :instructor
   #   @user = 
   # end
   # @user = User.new
    flash[:notice] = "Cannot add new student yet!"
    redirect_to users_path
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.roles << :student
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    begin
      User.import(params[:file])
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

    def find_students_for_professor
      users = []
      @professor = current_user
      @courses = @professor.courses
      for course in @courses
        for user in course.users
          if user.has_role? :student
            users << user
          end
        end
      end
      users
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
