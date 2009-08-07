class OpenLevel
  PRIVATE=0
  LIST_ONLY=2
  READ_ONLY=3
  PUBLIC=999
  
  def self.options
    [['비공개', PRIVATE], ['목록만 공개', LIST_ONLY], ['내용 공개', READ_ONLY], ['완전공개', PUBLIC]]
  end
end