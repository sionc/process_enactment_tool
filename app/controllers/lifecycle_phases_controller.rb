# This is the controller for our lifecycle phase resource. It sets up instance
# variables that will be used in the views. This controller provides
# functionality for creating and updating lifecycle phases.
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
        deliverable_type = create_deliverable_type(@lifecycle_phase)
        if (!deliverable_type.nil?)
          format.html { redirect_to(@lifecycle_phase.lifecycle, :notice => 'Lifecycle Phase was successfully created.') }
          format.xml { render :xml => @lifecycle_phase, :status => :created, :location => @lifecycle_phase }
        else
          @lifecycle = @lifecycle_phase.lifecycle
          format.html { render :action => "new" }
          format.xml { render :xml => @lifecycle_phase.errors, :status => :unprocessable_entity }
        end
      else
        @lifecycle = @lifecycle_phase.lifecycle
        format.html { render :action => "new" }
        format.xml { render :xml => @lifecycle_phase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lifecycle_phases/1
  # PUT /lifecycle_phases/1.xml
  def update
    lifecycle = Lifecycle.find(params[:lifecycle_id])
    ordered_phase_ids = params[:phases]
    ordered_lifecycle_phases = []
    ordered_phase_ids.each do |phase_id|
         ordered_lifecycle_phases << lifecycle.lifecycle_phases.find(phase_id)
    end
    puts ordered_lifecycle_phases.to_json
    swapped_index = 0
    ordered_count = ordered_lifecycle_phases.count
    for index in 1..(ordered_count - 1)
      for i in index+1..(ordered_lifecycle_phases.count)
        unless i > ordered_count
    	    if(ordered_lifecycle_phases[i-1].sequence_number == index)
            ordered_lifecycle_phases[i-1].update_attributes(:sequence_number => 0)
            swapped_index = i - 1	       	
          end
        end
      end
      
      current_sequence_num = ordered_lifecycle_phases[index-1].sequence_number
      ordered_lifecycle_phases[index-1].update_attributes(:sequence_number => index)
      ordered_lifecycle_phases[swapped_index].update_attributes(:sequence_number => current_sequence_num)
    end

    # return JSON string
    respond_to do |format|
      format.json { render :json => {:result => 'success'} }
    end
  end

  # Creates a DeliverableType and associates it with a Lifecycle Phase
  def create_deliverable_type(lifecycle_phase)
    unit_of_measure = UnitOfMeasure.find_by_unit("pages")
    if unit_of_measure.nil?
      temp_unit_of_measure = UnitOfMeasure.new(:unit => "pages")
      if (temp_unit_of_measure.save)
        unit_of_measure = temp_unit_of_measure
      else
        return
      end
    end
    type_name = @lifecycle_phase.name+" deliverable"
    deliverable_type = DeliverableType.new(:name => type_name,
                                           :lifecycle_phase_id => lifecycle_phase.id,
                                           :unit_of_measure_id => unit_of_measure.id)

    if deliverable_type.save
      return deliverable_type
    else
      return
    end
  end
end
