class EffortLogsController < ApplicationController

  before_filter :authenticate_user!, :except => []

  # GET /effort_logs/1
  # GET /effort_logs/1.xml
  def show
    @effort_log = EffortLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @effort_log }
    end
  end

  # GET /effort_logs/new
  # GET /effort_logs/new.xml
  def new
    @effort_log = EffortLog.new
    @deliverable_id = params[:deliverable_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @effort_log }
    end
  end

  # POST /effort_logs
  # POST /effort_logs.xml
  def create
    @effort_log = EffortLog.new(params[:effort_log])
    @effort_log.user_id = @current_user.id
    
    respond_to do |format|
      if @effort_log.save
        @deliverable = Deliverable.find(@effort_log.deliverable_id)
        
        format.html { redirect_to(@deliverable, :notice => 'Effort log was successfully created.') }
        format.xml  { render :xml => @effort_log, :status => :created, :location => @effort_log }
      else
         @deliverable_id = params[:effort_log][:deliverable_id]
        format.html { render :action => "new" }
        format.xml  { render :xml => @effort_log.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def does_not_overlap
    found_overlap = false
    start_date_time = params[:start_date_time]
    stop_date_time  = params[:stop_date_time]
    deliverable_id  = params[:deliverable_id]
    
    tmp_effort_log = EffortLog.new(:deliverable_id => deliverable_id, 
                                   :start_date_time => start_date_time, 
                                   :stop_date_time => stop_date_time)
                                   
    EffortLog.all.each do |effort_log|
      if tmp_effort_log.overlaps? (effort_log)
        found_overlap = true
      end
    end  
    
    # return a json string
    respond_to do |format|
      format.json { render :json => {:doesNotOverlap => !found_overlap} }
    end                                   
  end
end
