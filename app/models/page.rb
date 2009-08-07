class Page < ActiveRecord::Base
  simply_versioned :keep => 10 #, :automatic => false
  acts_as_viewed 
  acts_as_textiled :body

  belongs_to :user
  has_many :comments, :as => :commentable
  has_and_belongs_to_many :titles
  has_many :assets, :foreign_key => 'page_id', :conditions => "type = 'Asset'"

  validates_presence_of :title, :body
  validates_uniqueness_of :name, :case_sensitive => false, :allow_nil => true

  attr_accessor :noti, :do_not_apply_callback # virtual attributes
  def noti?; noti=="0" ? false: true end

  named_scope :bloggings, { :conditions => ['blogging = ?', true] }
  named_scope :recent, { :order => 'created_at DESC' }
  named_scope :pure_pages, { :conditions => "type = 'Page'" }
  named_scope :titled, lambda { |title| { :conditions => ['REPLACE(title, " ", "") = ?', title.gsub(' ', '')] }}

  def related_pages
    titles = Title.of(self.title)
    titles.inject([]) { |arr, title| arr << title.pages }.flatten.uniq - [self]
  end

  # callbacks
  after_create { |page| page.update_attribute(:name, "page_#{page.id}") if page.name.blank? }
  after_save :reindex_titles

  def to_param; name end

  protected

  # virtual attributes for assets upload
  def uploaded_assets=(uploaded_files)
    uploaded_files.each do |data|
      self.assets << Asset.new(:uploaded_data => data) unless data.blank?
    end
  end

  # TODO: code optimization
  def reindex_titles
    self.titles.destroy_all
    titles = self.body.scan(/\[\[(.*?)\]\]/).flatten
    titles.each do |title|
      self.titles << Title.create(:text => title)
    end
  end
  
end
