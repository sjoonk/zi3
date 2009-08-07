class EntriesController < ApplicationController

  # just a concept(customizing is required)
  def show
    @page = Page.find(params[:id])
    render :template => 'pages/show'
  end

end
