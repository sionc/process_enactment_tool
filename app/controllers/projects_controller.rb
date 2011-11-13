# This is the controller for our project resource. It sets up instance
# variables that will be used in the views. This controller provides 
# functionality for creating and reading our Project model.

class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/home
  def home
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @project }
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @lifecycles = Lifecycle.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # POST /projects
  # POST /projects.xml
  # On save, we associate phases and deliverable types
  def create
    @project = Project.new(params[:project])
    @lifecycles = Lifecycle.all

    respond_to do |format|
      if @project.save

        # If project is saved, then associate lifecycle_phases.
        @project.lifecycle_phases = Lifecycle.find_by_id(@project.lifecycle_id).lifecycle_phases
        
        # If project is saved, then associate deliverable types.
        @project.project_phases.each do |proj_phase|
          proj_phase.deliverable_types = LifecyclePhase.find(proj_phase.lifecycle_phase_id).deliverable_types
        end

        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

end
