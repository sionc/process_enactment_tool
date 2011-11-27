# This controller is for the administration of users.
# you can view individual users, modify them if you are an admin, and delete them.
# you can also see the entire list of all users
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => []
  
  before_filter :get_user, :only => [:index,:edit]
  before_filter :accessible_roles, :only => [:edit, :show, :update]
  # load_and_authorize_resource :only => [:show, :destroy, :edit, :update]
  load_and_authorize_resource 
  
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    # @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    # @user = User.find(params[:id])
    @roles = Role.all
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    # @user = User.find(params[:id])
    @role = Role.find(params[:user][:role])


    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        @roles = Role.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    # @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability,:read)
  end
 
  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
end
