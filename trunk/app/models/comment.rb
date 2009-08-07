class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true, :counter_cache => true, :dependent => :destroy
  belongs_to :user
  
  #acts_as_textiled :text
  acts_as_nested_set :scope => :commentable_id
  
  def commentable_name  
    (commentable.has_attribute?(:type) ? commentable[:type] : commentable_type).tableize  
  end
  def position_id; "comment_#{commentable.id}_#{self.parent_id || 0}" end
end
