require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe AssignmentsController, type: :controller do
  before(:each) do
    DatabaseCleaner.clean
    # @request.env["devise.mapping"] = Devise.mappings[:student]
    @student = create(:student)
    #puts @student.inspect
    @professor = create(:professor)
    @course = create(:course)
    @professor.add_role :professor
    @student.add_role :student
    sign_in @professor
  end

  # This should return the minimal set of attributes required to create a valid
  # Assignment. As you add validations to Assignment, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {assignment_name: "proj1-1", course_id: @course.id, deadline: DateTime.now + 7.days, id: 1, 
      created_at: DateTime.now - 7.days, updated_at: DateTime.now}
  }

  let(:invalid_attributes) {
    {assignment_name: "proj1-1", course_id: @course.id, deadline: DateTime.now - 7.days, id: 1, 
      created_at: DateTime.now + 7.days, updated_at: DateTime.now + 14.days}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AssignmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #new" do
    it "assigns a new assignment as @assignment" do
      get :new, {:course_id => @course.id}, valid_session
      expect(assigns(:assignment)).to be_a_new(Assignment)
    end
  end

  describe "GET #edit" do
    it "assigns the requested assignment as @assignment" do
      assignment = Assignment.create! valid_attributes
      get :edit, {:id => assignment.to_param, :course_id => @course.id}, valid_session
      expect(assigns(:assignment)).to eq(assignment)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Assignment" do
        expect {
          post :create, {:assignment => valid_attributes, :course_id => @course.id}, valid_session
        }.to change(Assignment, :count).by(1)
      end

      it "assigns a newly created assignment as @assignment" do
        post :create, {:assignment => valid_attributes, :course_id => @course.id}, valid_session
        expect(assigns(:assignment)).to be_a(Assignment)
        expect(assigns(:assignment)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved assignment as @assignment" do
        post :create, {:assignment => invalid_attributes, :course_id => @course.id}, valid_session
        expect(assigns(:assignment)).to be_a_new(Assignment)
      end

      it "re-renders the 'new' template" do
        post :create, {:assignment => invalid_attributes, :course_id => @course.id}, valid_session
        expect(response).to redirect_to :action => "new"
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {assignment_name: "proj1-2", course_id: @course.id, deadline: DateTime.now + 9.days, id: 1, 
        created_at: DateTime.now - 7.days, updated_at: DateTime.now}
      }

      it "updates the requested assignment" do
        assignment = Assignment.create! valid_attributes
        put :update, {:id => assignment.to_param, :assignment => new_attributes, :course_id => @course.id}, valid_session
        assignment.reload
        expect(assignment.assignment_name).to eq("proj1-2")
      end

      it "assigns the requested assignment as @assignment" do
        assignment = Assignment.create! valid_attributes
        put :update, {:id => assignment.to_param, :assignment => valid_attributes, :course_id => @course.id}, valid_session
        expect(assigns(:assignment)).to eq(assignment)
      end
    end

    context "with invalid params" do
      it "assigns the assignment as @assignment" do
        assignment = Assignment.create! valid_attributes
        put :update, {:id => assignment.to_param, :assignment => invalid_attributes, :course_id => @course.id}, valid_session
        expect(assigns(:assignment)).to eq(assignment)
      end

      it "redirects to the edit action" do
        assignment = Assignment.create! valid_attributes
        put :update, {:id => assignment.to_param, :assignment => invalid_attributes, :course_id => @course.id}, valid_session
        expect(response).to redirect_to :action => "edit"
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested assignment" do
      assignment = Assignment.create! valid_attributes
      expect {
        delete :destroy, {:id => assignment.to_param, :course_id => @course.id}, valid_session
      }.to change(Assignment, :count).by(-1)
    end
  end

end
