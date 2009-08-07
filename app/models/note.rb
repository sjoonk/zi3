class Note < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  belongs_to :board, :counter_cache => true
  has_many :comments, :as => :commentable

  acts_as_textiled :body
  
  validates_presence_of :body

  named_scope :recent, lambda { |*args| { :limit => args.first || 5, :order => 'created_at DESC', :include => :user }}
end
