class DeliverablesController < ApplicationController
  # GET /deliverables
  # GET /deliverables.xml
  def index

    # Copied from railscasts.com (#154-polymorphic-assocation)

 #   @project_deliverable_type = find_project_deliverable_type
 #   @deliverables = @project_deliverable_type.deliverables

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

  # GET /deliverables/new
  # GET /deliverables/new.xml
  def new
    @deliverable = Deliverable.new

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

    @project_deliverable_type = find_project_deliverable_type
    @deliverable = @project_deliverable_type.deliverables.build(params[:deliverable])

    respond_to do |format|
      if @deliverable.save
        format.html { redirect_to(@deliverable, :notice => 'Deliverable was successfully created.') }
        format.xml  { render :xml => @deliverable, :status => :created, :location => @deliverable }
      else
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
end


# Copied from railscasts.com (#154-polymorphic-assocation)

private

def find_project_deliverable_type
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
end