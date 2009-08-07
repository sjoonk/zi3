class UsersController < ApplicationController
  PER_PAGE = 20
  
  # Protect these actions behind an admin login
  require_role "admin", :only => [:suspend, :unsuspend, :destroy, :purge, :activate]

  before_filter :login_required, :except => [:new, :create, :activate]
  before_filter :find_user, :only => [:activate, :suspend, :unsuspend, :destroy, :purge]
  
  def index
    @users = User.paginate :page => params[:page], :per_page => PER_PAGE, :order => 'updated_at DESC'
  end

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by_login(params[:id])
    if @user == current_user
      render :action => 'edit' 
    else
      @posts = @user.posts.recent(5)
      render :action => 'show'
    end
  end
 
 	def update
		@user = User.find_by_login(params[:id])
		access_denied if @user != current_user
		if @user.update_attributes(params[:user])
      redirect_to user_url(current_user)
      flash[:notice] = "User Profile was updated!"
    else
      render :action => 'edit'
    end
	end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    # Added by me (2008.10.02)
    if request.xhr?
      @user.activate!
      respond_to do |format|
        format.html { redirect_to users_path }
        #format.js { head :ok }
        format.js { render :text => select_state(@user) }
      end
    else
      logout_keeping_session!
      user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
      case
      when (!params[:activation_code].blank?) && user && !user.active?
        user.activate!
        flash[:notice] = "Signup complete! Please sign in to continue."
        redirect_to '/login'
      when params[:activation_code].blank?
        flash[:error] = "The activation code was missing.  Please follow the URL from your email."
        redirect_back_or_default('/')
      else 
        flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
        redirect_back_or_default('/')
      end
    end
  end

  def suspend
    @user.suspend! 
    respond_to do |format|
      format.html { redirect_to users_path }
      #format.js { head :ok }
      format.js { render :partial => 'select_state', :locals => { :user => @user } }
    end
  end

  def unsuspend
    @user.unsuspend! 
    respond_to do |format|
      format.html { redirect_to users_path }
      #format.js { head :ok }
      format.js { render :partial => 'select_state', :locals => { :user => @user } }
    end
  end

  def destroy
    @user.delete!
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js { head :ok }
    end
  end

  def purge
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js { head :ok }
    end
  end
  
  # There's no page here to update or destroy a user.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_user
    @user = User.find(params[:id])
  end
end
