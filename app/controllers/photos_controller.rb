class PhotosController < ApplicationController
  before_filter :login_required
  
  def show
    @album = Album.find(params[:album_id])
    @photo = @album.photos.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.js { render :text => @photo.title }
      else
        flash[:error] = @photo.errors.full_messages.join('\n')
        format.js {
          render :update do |page| 
            page.alert flash[:error] 
          end
        }  
      end
    end
  end
end
