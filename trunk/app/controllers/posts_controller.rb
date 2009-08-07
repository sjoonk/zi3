class PostsController < ApplicationController
  #before_filter :login_required, :except => [:home]
  before_filter :find_board, :except => [:home]
  before_filter :check_open_level, :except => [:home]
  
  PER_PAGE = 10
  
  def home
    @posts = Post.pure_posts.recent
    @popular_posts = Post.popular_posts.all :limit => 7
    @replies = Post.all :conditions => 'parent_id IS NOT NULL', :limit => 5, :order => 'updated_at DESC', :include => {:post => :board}
    @notes = Note.recent
    @photos = Photo.recent
    @assets = Asset.pure_assets.recent.all :limit => 8
    @events = Event.all :order => 'started_at'
    @time = params[:time] ? params[:time].to_time : Time.now
  end
  
  def index
    @posts = Post.board_of(@board).paginate :page => params[:page], :per_page => PER_PAGE, :include => :user
    @posts_count = Post.board_of(@board).count 
    @title = @board.title
  end

  def show
    # TODO: Refactoring!
    @post = @board.posts.find(params[:id])
    @original_post = @post
    index
    unless params[:version].blank?
      @version = params[:version].to_i
      @post = Post.new(YAML::load(@post.versions.get(@version).yaml))
    else
      @version = @post.version_number
      @post.do_not_apply_callback = true
      @post.with_versioning(false) do |post|
        Post.record_timestamps = false
        post.view request.remote_ip, current_user
        Post.record_timestamps = true
      end
      titles = Title.of(@post.title)
      @related_pages = titles.inject([]) { |arr, title| arr << title.pages }.flatten.uniq - [@post]
    end  
  end

  def download
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = @board.posts.build(params[:post])
    @post.user = current_user if logged_in?
    @post.board = @board
    if @post.save
      respond_to do |format| 
        format.html { redirect_to board_post_url(@board, @post) }
        format.js {
          render :update do |page|
            page.insert_html :bottom, 'reply_list', :partial => 'reply'
          end
        }
      end
    else
      render :action => 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user # editable for every logged-in user

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to board_post_url(@board, @post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end
  
  private
  
  def find_board
    @board ||= params[:board] ? 
      Board.find_by_name(params[:board]) : Board.find(params[:board_id])
  end
  
  protected

  def check_open_level
    case
    when action_name == 'index'
      login_required if @board.open_level < OpenLevel::LIST_ONLY
    when action_name == 'show'
      login_required if @board.open_level < OpenLevel::READ_ONLY
    else
      login_required if @board.open_level < OpenLevel::PUBLIC
    end
  end
end
