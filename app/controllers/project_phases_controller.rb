class ProjectPhasesController < ApplicationController
  #Return JSON string for project phase details. Will be used by project show page.
  def show
    @project_phase = ProjectPhase.find_by_id(params[:id])
    @lifecycle_phase = LifecyclePhase.find_by_id(@project_phase.lifecycle_phase_id)

    respond_to do |format|

      format.json { render :json => @lifecycle_phase }

    end

  end

end
