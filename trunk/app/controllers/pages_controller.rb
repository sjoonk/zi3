class PagesController < ApplicationController
  before_filter :login_required, :except => [:show]
  
  def index
    if title = params[:title]
      pages = Page.titled(title)
      if pages.empty?
        new
        @page.title = title
        render :action => 'new'
      elsif pages.size > 1
        @pages = Page.titled(title).paginate :page => params[:page], :order => 'updated_at DESC'
        @pages_count = Page.titled(title).count
        @title = "Pages of title '#{title}'"
      else # size == 1
        @page = pages.first
        fetch_related_pages(@page)
        render :action => 'show'
      end  
    else
      @pages = Page.pure_pages.paginate :page => params[:page], :order => 'updated_at DESC'
      @pages_count = Page.pure_pages.count
      @title = "All pages"
    end
  end
  
  def show
    @page = Page.find_by_name(params[:id])
    @page = Page.find(params[:id]) unless @page
    if @page
      @related_pages = @page.related_pages
    else
      if logged_in?
        new
        render :action => 'new'
      else
        redirect_to root_path
      end
    end
  end
  
  def new
    @page = Page.new(:name => params[:id])
  end
  
  def edit
    @page = Page.find_by_name(params[:id])
  end
  
  def create
    @page = current_user.pages.build(params[:page])
    @page.type = 'Page' # I don't know why this is required, but didn't work without this
    if @page.save
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def update
    @page = Page.find_by_name(params[:id])
    if @page.collaborable? || (@page.user == current_user)
      @page.user = current_user # anyone can edit
      @page.update_attributes(params[:page])
      redirect_to @page
    else  
      flash[:error] = '죄송합니다. 권한이 없습니다.'
      render :action => 'edit'
    end
  end
  
  def destroy
    Page.find_by_name(params[:id]).destroy
    redirect_to pages_path
  end
  
  private
  
  def fetch_related_pages(page)
    titles = Title.of(page.title)
    @related_pages = titles.inject([]) { |arr, title| arr << title.pages }.flatten.uniq - [page]
  end
end
