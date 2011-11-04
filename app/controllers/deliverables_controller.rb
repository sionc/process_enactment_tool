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

  # Copied from railscasts.com (#154-polymorphic-assocation)
  # modified to fit our needs so we can find the deliverable type
  private

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


