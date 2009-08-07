class Post < Page
  belongs_to :board, :counter_cache => true
  
  # self-referential replies
  has_many :replies, :class_name => "Post", :foreign_key => "parent_id", :order => 'created_at'
  belongs_to :post, :class_name => "Post", :foreign_key => "parent_id", :counter_cache => 'replies_count', :dependent => :destroy

  # for anonymous visitor
  attr_accessor :im_human
  validates_acceptance_of :im_human, :allow_nil => true
  validates_presence_of :visitor, :if => :im_human

  def is_reply?; !parent_id.nil? end

  # eager loading does not work in named_scope??
  named_scope :pure_posts, { :conditions => 'parent_id IS NULL', :order => 'updated_at DESC', :include => [:user, :board] }
  named_scope :popular_posts, { :conditions => 'parent_id IS NULL', :order => 'views DESC, updated_at DESC', :include => [:user, :board] }
  named_scope :board_of, lambda { |board| { :conditions => ['board_id = ?', board.id], :order => 'updated_at DESC' }}
  named_scope :recent, lambda { |*args| { :limit => args.first || 7, :order => 'updated_at DESC', :include => [:user, :board] }}

  # override(restore to default)
  def to_param; id.to_s end
  
end
