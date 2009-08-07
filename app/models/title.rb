class Title < ActiveRecord::Base
  has_and_belongs_to_many :pages
  named_scope :of, lambda { |text| { :conditions => ['REPLACE(text, " ", "") = ?', text.gsub(' ', '')] }}
end
