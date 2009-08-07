class Asset < ActiveRecord::Base
  belongs_to :page, :foreign_key => 'page_id', :counter_cache => true, :dependent => :destroy

  has_attachment :storage => :file_system,
                 :path_prefix => 'assets',
                 :max_size => 100.megabytes

  validate :attachment_valid?
  
  named_scope :recent, lambda { |*args| { :limit => args.flatten.first || 5,
                                :order => 'created_at DESC', :conditions => 'parent_id IS NULL' }}
  named_scope :pure_assets, { :conditions => "type = 'Asset'" }
  
  protected
  
  def attachment_valid?
    errors.add_to_base("선택된 파일이 없습니다") unless self.filename
    
    content_type = attachment_options[:content_type]
    unless content_type.nil? || content_type.include?(self.content_type)
      errors.add_to_base "허용되지 않는 파일 유형입니다"
    end
    
    size = attachment_options[:size]
    unless size.nil? || size.include?(self.size)
      errors.add_to_base "파일 크기가 #{}를 초과하였습니다"
    end
  end
    
end
