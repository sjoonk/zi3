class Event < Page
  named_scope :month, lambda { |time| { 
    :conditions => ['started_at BETWEEN ? AND ?', time.beginning_of_month, time.end_of_month],
    :order => 'started_at' 
  }}

  def date; started_at end
end