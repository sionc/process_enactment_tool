class ProjectPhasesController < ApplicationController
  #Return JSON string for project phase details. Will be used by project show page.
  def show
    @project_phase = ProjectPhase.find(params[:id])
    @lifecycle_phase = @project_phase.lifecycle_phase
    @project_phase_deliverables = []
    @project_phase.stock_deliverable_types.each do |stock|
      stock.deliverables.each do |d|
        @project_phase_deliverables << d
      end
    end

    respond_to do |format|
      format.json { render :json => { :phase => @lifecycle_phase,
                                      :stock_deliverables => @project_phase_deliverables} }
    end
  end

end
