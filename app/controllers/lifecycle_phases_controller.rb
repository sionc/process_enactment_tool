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


end
