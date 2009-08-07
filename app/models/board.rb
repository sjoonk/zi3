class Board < ActiveRecord::Base
  has_many :posts
  validates_presence_of :title
  
  named_scope :pure_boards, { :conditions => "type = 'Board'" }
  
  def is_public?
    self.open_level == OpenLevel::PUBLIC
  end
end
