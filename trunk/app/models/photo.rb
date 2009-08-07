class Photo < Asset
  belongs_to :album, :foreign_key => 'board_id', :counter_cache => :assets_count, :dependent => :destroy
  has_many :comments, :as => :commentable

  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :path_prefix => 'public/photos',
                 :max_size => 500.kilobytes,
                 :resize_to => '640x480>',
                 :thumbnails => { :thumb => [100, 100] }

  # named_scope :recent, lambda { |*args| { :limit => args.flatten.first || 7, :include => :album,
  #                               :order => 'created_at DESC', :conditions => 'parent_id IS NULL' }}
  def self.recent(limit=7)
    all :limit => limit, :order => 'created_at DESC', :conditions => 'parent_id IS NULL', :include => :album
  end
                                
  def next
   Photo.first :conditions => ['parent_id IS NULL AND board_id = ? AND id < ? ', board_id, id], :order => 'id DESC'
  end
  def previous
   Photo.first :conditions => ['parent_id IS NULL AND board_id = ? AND id > ? ', board_id, id], :order => 'id DESC'
  end  

end
