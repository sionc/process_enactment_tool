# This is the controller for our deliverable resource. It sets up instance
# variables that will be used in the views. This controller provides 
# functionality for creating both stock and custom deliverables. It also
# provides functions used in deliverable-related AJAX calls that return
# JSON strings.

class DeliverablesController < ApplicationController
  # GET /deliverables
  # GET /deliverables.xml
  def index
    @deliverables = Deliverable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @deliverables }
    end
  end

  # GET /deliverables/1
  # GET /deliverables/1.xml
  def show
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @deliverable }
    end
  end

  # GET /deliverables/show_phase_deliverables
  # Action to respond to ajax call to get the deliverables for the selected phase
  def show_phase_deliverables
    @deliverable = Deliverable.all

    respond_to do |format|
      format.json { render :json => @deliverable }
    end
  end

  # GET /deliverables/new
  # GET /deliverables/new.xml
  def new
    @deliverable = Deliverable.new
    @project_phase_id = params[:project_phase_id]

    gather_collections

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @deliverable }
    end
  end

  # GET /deliverables/1/edit
  def edit
    @deliverable = Deliverable.find(params[:id])
  end

  # POST /deliverables
  # POST /deliverables.xml
  # We are using polymorphic associations to create this deliverable
  # created through @assignable
  def create
    @assignable = find_assignable

    @deliverable = @assignable.deliverables.build(:name => params[:deliverable][:name],
                                                  :description => params[:deliverable][:description],
                                                  :estimated_effort => params[:deliverable][:estimated_effort],
                                                  :estimated_size => params[:deliverable][:estimated_size],
                                                  :estimated_production_rate => params[:deliverable][:estimated_production_rate],
                                                  :complexity_id => params[:deliverable][:complexity_id])


    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully created.') }
        format.xml { render :xml => @deliverable, :status => :created, :location => @deliverable }
      else
        @assignable = nil
        @project_phase_id = params[:deliverable][:project_phase_id]

        gather_collections

        format.html { render :action => "new" }
        format.xml { render :xml => @deliverable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /deliverables/1
  # PUT /deliverables/1.xml
  def update
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      if @deliverable.update_attributes(params[:deliverable])
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @deliverable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /deliverables/1
  # DELETE /deliverables/1.xml
  def destroy
    @deliverable = Deliverable.find(params[:id])
    @deliverable.destroy

    respond_to do |format|
      format.html { redirect_to(deliverables_url) }
      format.xml { head :ok }
    end
  end

  # Creates a CustomDeliverableType
  # Associates a ProjectPhase and UnitOfMeasure to the CustomDeliverableType
  def create_custom_deliverable_type
    # we get the posted variables
    # save them to the database
    custom_deliverable_type = CustomDeliverableType.new(:name => params[:name],
                                                        :project_phase_id => params[:project_phase_id],
                                                        :unit_of_measure_id => params[:unit_of_measure_id])
    # return a json string
    respond_to do |format|
      if custom_deliverable_type.save
        format.json { render :json => {:name => custom_deliverable_type.name,
                                       :id => custom_deliverable_type.id} }
      else
        format.json { render :json => {:error => "Some errors"} }
      end
    end
  end

  # Gets the UnitOfMeasure associated with the DeliverableType
  def get_unit_of_measure
    if params[:assignable_type] == "StockDeliverableType"
			stock_deliverable_type = StockDeliverableType.find(params[:assignable_id])
      unit_of_measure_name = stock_deliverable_type.deliverable_type.unit_of_measure.unit
     else
			unit_of_measure_name = CustomDeliverableType.find(params[:assignable_id]).unit_of_measure.unit
		end
	
    # return a json string
    respond_to do |format|
      format.json { render :json => {:name => unit_of_measure_name} }
    end
  end

  # Gets the Historical data for the given deliverable type and complexity
  def get_historical_data
    return_val = []
    if params[:stock_deliverable_type_id] && params[:complexity_id]
      del_type_id = params[:stock_deliverable_type_id]
      complexity_id = params[:complexity_id]
      
      stock_deliverable_type = StockDeliverableType.find_by_id(del_type_id)
      unless stock_deliverable_type.nil?
        min_record = stock_deliverable_type.get_del_with_min_effort(complexity_id)
        avg_record = stock_deliverable_type.get_del_with_avg_effort(complexity_id)
        max_record = stock_deliverable_type.get_del_with_max_effort(complexity_id)
        
        unless min_record.nil? && avg_record.nil? && max_record.nil?
          return_val[0] = [min_record.estimated_size, min_record.estimated_production_rate, min_record.estimated_effort]
          return_val[1] = [avg_record.estimated_size, avg_record.estimated_production_rate, avg_record.estimated_effort]
          return_val[2] = [max_record.estimated_size, max_record.estimated_production_rate, max_record.estimated_effort]
        end
      end
    end
    # return a json string
    respond_to do |format|
      format.json { render :json => {:hist => return_val} }
    end
  end

  private

  # Finds a StockDeliverableType or CustomDeliverableType based on the
  # assignable_id (See Deliverable).
  # This method expects a valid stock_deliverable_type_id or a
  # custom_deliverable_type_id.
  # Copied from railscasts.com (#154-polymorphic-assocation)
  # modified to fit our needs so we can find the deliverable type
  def find_assignable
    params[:deliverable].each do |name, value|
      # (.+) extracts the substring before _deliverable_type_id
      # $1 could be "custom" or "stock"
      if name =~ /(.+)_deliverable_type_id$/
        return ($1+"_deliverable_type").classify.constantize.find(value)
      end
    end
    nil
  end

  # This method is used by the DeliverablesController.new and
  # DeliverablesController.edit to gather the collections that need
  # to be displayed on the associated forms.
  def gather_collections
    project_phase = ProjectPhase.find(@project_phase_id)

    # TODO: Add the custom deliverables into this list

    # Encode the id as stock_<id>
    sdt = project_phase.stock_deliverable_types unless project_phase.nil?
    @stock_deliverable_types = sdt.map {|s| [s.deliverable_type.name, "stock_" + s.id.to_s]}

    @complexities = Complexity.all
    @units_of_measure = UnitOfMeasure.all
  end
end


