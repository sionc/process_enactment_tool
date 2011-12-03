class LifecyclePhasesController < ApplicationController

  before_filter :authenticate_user!, :except => []
  before_filter :accessible_roles, :only => [:new, :create]
  load_and_authorize_resource

  # GET /lifecycle_phases/new
  # GET /lifecycles_phases/new.xml
  def new
    #@lifecycle_phase = LifecyclePhase.new
    @lifecycle = Lifecycle.find(params[:lifecycle_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lifecycle_phase }
    end
  end

 # POST /lifecycles
  # POST /lifecycles.xml
  def create
    #@lifecycle_phase = Lifecycle.new(params[:lifecycle_phase])
    lifecycle = Lifecycle.find(params[:lifecycle_phase][:lifecycle_id])
    sequence_num = lifecycle.lifecycle_phases.count + 1
    @lifecycle_phase.sequence_number = sequence_num
    respond_to do |format|
      if @lifecycle_phase.save
        format.html { redirect_to(@lifecycle_phase.lifecycle, :notice => 'Lifecycle Phase was successfully created.') }
        format.xml  { render :xml => @lifecycle_phase, :status => :created, :location => @lifecycle_phase }
      else
        @lifecycle = @lifecycle_phase.lifecycle
        format.html { render :action => "new" }
        format.xml  { render :xml => @lifecycle_phase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deliverables/1
  # PUT /deliverables/1.xml
  def update
    lifecycle = Lifecycle.find(params[:lifecycle_id])
    lifecycle_phases_to_sort = lifecycle.lifecycle_phases
    ordered_phase_ids = params[:lifecycle_phase_ids]
    max_count = ordered_phase_ids.count - 1

    for i in 0..(max_count)
      swap_phase_1 = lifecycle_phases_to_sort.find_by_id(ordered_phase_ids[i])
      swap_phase_2 = lifecycle_phases_to_sort.find_by_sequence_number(i)

      temp_sequence_number = swap_phase_1.sequence_number
      swap_phase_1.update_attributes(:sequence_number => swap_phase_2.sequence_number)
      swap_phase_2.update_attributes(:sequence_number => temp_sequence_number)
    end

    respond_to do |format|
      format.json { render :json => {:result => 'success'} }
    end
  end
end
