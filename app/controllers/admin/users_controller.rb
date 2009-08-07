class Admin::UsersController < ApplicationController
  require_role "admin"
  
  def index
    @users = User.all :order => 'created_at DESC'
  end
end
