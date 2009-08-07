class Admin::MenuController < ApplicationController
  require_role "admin"
  
  def edit
    @text = Menu.textile
  end
  
  def save
    Menu.refresh(params[:menu_text])
    redirect_to :back
  end
end
