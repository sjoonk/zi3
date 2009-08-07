class ApplyActsAsViewedToPost < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.create_viewings_table
    add_column :posts, :views, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :views
    ActiveRecord::Base.drop_viewings_table
  end
end
