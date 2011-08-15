class RolesController < ApplicationController
  
  respond_to :html, :xml, :json
  
  def new
    @role = project.roles.new       # look to the private method below for this
    
    respond_with [project, @role]   # because this is nested in a project
  end
  
  def create
    @role = project.roles.new(params[:role])
    new_was_successful = @role.save
    
    respond_with [project, @role] do |format|
      format.html {
        if new_was_successful
          redirect_to(project_path(project), :notice => 'The role was
          created')
        else
          render 'new'
        end
      }
    end
  end
  
  def edit
    @role = project.roles.find(params[:id])       #change 'new' to find(params[:id]) 
    
    respond_with [project, @role]   
  end
  
  def update
    @role = project.roles.find(params[:id])   #change 'new' to find(params[:id]) 
    update_was_successful = @role.update_attributes(params[:role])  
          #changed above to update_was_successful & update_atts(p[:role])
    respond_with [project, @role] do |format|
      format.html {
        if update_was_successful
          redirect_to(project_path(project), :notice => 'The role was
          saved')
        else
          render 'edit'
        end
      }
    end
  end
  
  ## destroy is for controllers and models --- delete is for URLs
  def destroy
    role = project.roles.find(params[:id])  # make sure roles is plural
    if role.destroy
      flash[:notice] = 'The role was destroyed'
    else
      flash[:alert] = 'The role could not be destroyed'
    end
    
    respond_with [project, @role] do |format|
      format.html {
        redirect_to(project_path(project))
      }
    end    
  end
  
  private
  
  def project
    @project ||= Project.find(params[:project_id])
  end
  
end