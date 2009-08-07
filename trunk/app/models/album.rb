class Album < Board
  belongs_to :user
  has_many :photos, :foreign_key => 'board_id', :order => 'id DESC' # Do not use timestamp!!
end
