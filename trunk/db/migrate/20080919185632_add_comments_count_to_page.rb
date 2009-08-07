class AddCommentsCountToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :pages, :comments_count
  end
end
