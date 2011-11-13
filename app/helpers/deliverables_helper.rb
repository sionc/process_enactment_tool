module DeliverablesHelper

  # Gets the project associated with the deliverable
  def get_project
     @deliverable.assignable.project_phase.project
  end
end
