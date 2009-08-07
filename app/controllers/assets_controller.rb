class AssetsController < ApplicationController
  before_filter :login_required

  def show
    @asset = Asset.find(params[:id])  
    send_file @asset.full_filename, :filename => @asset.filename, :type => @asset.content_type, :disposition => 'inline'
  end
  
  def download
    send_file @asset.full_filename, :filename => @asset.filename, :type => @asset.content_type, :disposition => 'attachment'
  end

end
