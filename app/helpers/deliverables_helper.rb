module DeliverablesHelper

  def get_project
     @deliverable.assignable.project_phase.project
  end
end
