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
            
            
            
            
            
            
                
        
    # unless ordered_phase_ids.count <= 1
    #   # Loop through all of the ordered_phase_ids given to us 
    #   for i in 0..(ordered_phase_ids.count - 2)
    #     # get the ith element in the ordered phase array and find the associated phase
    #     swap_phase_id_1 = ordered_phase_ids[i]
    #     
    #     # get the ith element in the lifecycle_phases_to_sort array
    #     # note: the lifecycle_phases_to_sort is already sorted by sequence number
    #     swap_phase_id_2 = lifecycle.lifecycle_phases[i].id
    # 
    #     # Save the original sequence numbers for both records
    #     orig_phase_1_seq_num = lifecycle.lifecycle_phases.find(swap_phase_id_1).sequence_number
    #     orig_phase_2_seq_num = lifecycle.lifecycle_phases.find(swap_phase_id_2).sequence_number
    #     
    #     # swap the sequence numbers using 0 as the temp sequence number
    #     # using 0 is the only number that will preserve our validations
    #     lifecycle.lifecycle_phases.find(swap_phase_id_2).update_attributes(:sequence_number => 0)
    #     lifecycle.lifecycle_phases.find(swap_phase_id_1).update_attributes(:sequence_number => orig_phase_2_seq_num)
    #     lifecycle.lifecycle_phases.find(swap_phase_id_2).update_attributes(:sequence_number => orig_phase_1_seq_num)
    #   end
    # end
    
    respond_to do |format|
      format.json { render :json => {:result => 'success'} }
    end
  end
end
