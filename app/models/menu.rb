class Menu
  MENU_FILE = "#{RAILS_ROOT}/config/menu.textile"
  @@html = nil
  
  def self.html; @@html || refresh end
  def self.textile; File.new(MENU_FILE).read end

  def self.refresh(text=nil)
    File.open(MENU_FILE, 'w') {|f| f.write(text) } unless text.blank?
    @@html = RedCloth.new(textile).to_html
  end
end
