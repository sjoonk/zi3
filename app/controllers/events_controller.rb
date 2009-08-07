class EventsController < ApplicationController
  before_filter :login_required
  
  make_resourceful do
    actions :all
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    if @event.save
      redirect_to @event
    else
      render :action => 'new'
    end
  end
    
  private
  
  def current_objects
    @time = params[:time] ? params[:time].to_time : Time.now
    @current_object ||= current_model.month(@time).group_by { |event| event.date.to_date }
  end
  
end
