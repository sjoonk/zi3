class AlbumsController < ApplicationController
  before_filter :login_required
  PER_PAGE = 7
  PHOTO_PER_PAGE = 12

  def index
    @albums = Album.paginate :page => params[:page], :per_page => PER_PAGE, :order => 'updated_at DESC'
    @albums_count = Album.count
  end

  def show
    @album = Album.find(params[:id])
    @photos = @album.photos.paginate :page => params[:page], :per_page => PHOTO_PER_PAGE
  end

  def new
    @album = Album.new
  end
  
  def create
    @album = current_user.albums.build(params[:album])
    if @album.save
      redirect_to @album
    else
      render :action => 'new'
    end
  end

  def update
    @album = Album.find(params[:id])
    params[:photos].each do |data|
      @album.photos << Photo.new(:uploaded_data => data) unless data.blank?
    end  
    unless @album.save
      flash[:error] = @album.errors.full_messages.join('\n')
    end
    redirect_to @album
  end
  
end
