class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    # binding.pry

    # @assignments = Assignment.all
    @assignments = current_user.assignments
    # respond_with(@assignments)
  end

  def show

    respond_with(@assignment)
  end

  def new
    @assignment = Assignment.new
    respond_with(@assignment)
  end

  def edit
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.save
    respond_with(@assignment)
  end

  def update
    @assignment.update(assignment_params)
    respond_with(@assignment)
  end

  def destroy
    @assignment.destroy
    respond_with(@assignment)
  end

  private
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    def assignment_params
      params.require(:assignment).permit(:user_id, :issue_id)
    end
end
