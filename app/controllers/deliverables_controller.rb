class DeliverablesController < ApplicationController
  # GET /deliverables
  # GET /deliverables.xml
  def index
    @deliverables = Deliverable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @deliverables }
    end
  end

  # GET /deliverables/1
  # GET /deliverables/1.xml
  def show
    @deliverable = Deliverable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deliverable }
    end
  end

  def show_phase_deliverables
    @deliverable = Deliverable.all

      respond_to do |format|
        format.json  { render :json => @deliverable }
      end
    end

  # GET /deliverables/new
  # GET /deliverables/new.xml
  def new
    @deliverable = Deliverable.new
    @project_phase_id = params[:project_phase_id]
    project_phase = ProjectPhase.find(@project_phase_id)
    @stock_deliverable_types = project_phase.stock_deliverable_types unless project_phase.nil?

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @deliverable }
    end
  end

  # GET /deliverables/1/edit
  def edit
    @deliverable = Deliverable.find(params[:id])
  end

  # POST /deliverables
  # POST /deliverables.xml
  def create
    @assignable = find_assignable
    @deliverable = @assignable.deliverables.build(:name => params[:deliverable][:name], 
                                                  :description => params[:deliverable][:description],
                                                  :estimated_effort => params[:deliverable][:estimated_effort],
                                                  :estimated_size => params[:deliverable][:estimated_size],
                                                  :estimated_production_rate => params[:deliverable][:estimated_production_rate])                                                   
                                                   

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully created.') }
        format.xml  { render :xml => @deliverable, :status => :created, :location => @deliverable }
      else        
        @assignable = nil
        @project_phase_id = params[:deliverable][:project_phase_id]
        project_phase = ProjectPhase.find(@project_phase_id)
        @stock_deliverable_types = project_phase.stock_deliverable_types unless project_phase.nil?
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @deliverable.errors, :status => :unprocessable_entity }
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
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deliverable.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end


  # Copied from railscasts.com (#154-polymorphic-assocation)

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

end


