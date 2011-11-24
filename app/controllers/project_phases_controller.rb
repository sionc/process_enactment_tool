# This is the controller for our project phase resource. 
# It provides functions (that return JSON strings) in support of AJAX calls
# on our projects/show page. 

class ProjectPhasesController < ApplicationController

  before_filter :authenticate_user!, :except => []

  # Return JSON string for project phase details. Will be used by project show page.
  def show
    @project_phase = ProjectPhase.find(params[:id])
    @lifecycle_phase = @project_phase.lifecycle_phase
    @project_phase_deliverables = []
    @project_phase.stock_deliverable_types.each do |stock|
      stock.deliverables.each do |d|
        @project_phase_deliverables << d
      end
    end

    @project_phase.custom_deliverable_types.each do |custom|
      custom.deliverables.each do |d|
        @project_phase_deliverables << d
      end
    end

    respond_to do |format|
      format.json { render :json => { :lifecycle_phase_container => @lifecycle_phase,
                                      :deliverables_container => @project_phase_deliverables,
                                      :project_phase_estimated_effort => @project_phase.estimated_effort,
                                      :project_phase_logged_effort => @project_phase.logged_effort} }
    end
  end

end
