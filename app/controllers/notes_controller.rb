class NotesController < ApplicationController
  before_filter :login_required #, :except => [:index]
  PER_PAGE = 15
  
  def index
    @notes = Note.paginate :page => params[:page], :per_page => PER_PAGE, 
                           :order => 'created_at DESC', :include => [:user, {:comments => [:user, :commentable]}]
    @grouped_notes = @notes.group_by{ |note| note.created_at.to_date }
  end

  def create
    @note = current_user.notes.build(params[:note])
    @note.save
    redirect_to notes_path
  end
end
