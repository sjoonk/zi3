class RolesController < ApplicationController
  require_role "admin"
  
  def update
    @user = User.find_by_login(params[:user_id])
    @role = Role.find(params[:id])
    if params[:role] == true
      @user.roles << @role
    else
      @user.roles.delete @role
    end
    respond_to do |format|
      format.js { head :ok }
    end
  end
      
end